import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/html_escape.dart';
import 'package:html/parser.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/models/data_model.dart';
import 'package:task_P2/core/data/models/project_model.dart';
import 'package:task_P2/core/data/repository/data_table_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:task_P2/core/data/models/data_model.dart';
import 'package:task_P2/core/data/repository/project_repository.dart';

class ServicesViewController extends GetxController {
   static ServicesViewController get instance=>Get.find();
  RxList<ProjectModel> dataList = <ProjectModel>[].obs;
  RxList<ProjectModel> filteredDataList = <ProjectModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  RxString selectedValueOnDropDown = "كل الطلبات".obs;
  RxInt sortColumnIndex = 0.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController();
  final RxBool shouldRefresh = false.obs;




  @override
  void onInit() {
    super.onInit();
    getData();
     ever(shouldRefresh, (val) {
    if (val == true) {
      getData(); // تحديث البيانات
      shouldRefresh.value = false; // إعادة الضبط
    }
  });
  }
void markForRefresh() {
  shouldRefresh.value = true;
}
  void sortById(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredDataList.sort((a, b) {
      final aValue = a.id ?? 0;
      final bValue = b.id ?? 0;
      return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    });

    selectedRows
        .assignAll(List.generate(filteredDataList.length, (_) => false));
  }

  void searchQuery(String query) {
    final lowerQuery = query.toLowerCase().trim();

    if (lowerQuery.isEmpty) {
      // عرض كل البيانات إذا كان البحث فارغًا
      filteredDataList.assignAll(dataList);
    } else {
      final result = dataList.where((item) {
        return [
          item.beneficiary!.fullName??"",
          item.id,
          item.requestDate,
          item.aidTypeDisplay,
          item.category,
          item.beneficiary!.phoneNumber,
          
        ].any((value) => value?.toString().toLowerCase().contains(lowerQuery) ?? false);
      }).toList();

      filteredDataList.assignAll(result);
    }

    selectedRows
        .assignAll(List.generate(filteredDataList.length, (_) => false));
  }

  void getData() {
    ProjectRepository().getAllProjects().then((value) {
      value.fold(
        (l) => BotToast.showText(text: l),
        (r) {
          dataList.assignAll(r);
          filteredDataList.assignAll(r);
          selectedRows.assignAll(List.generate(r.length, (_) => false));
        },
      );
    });
  }

  void filterOrders() {
    //عدل username الئ status
    if (selectedValueOnDropDown == "كل الطلبات") {
      filteredDataList.value = dataList;
    } else if (selectedValueOnDropDown == "مشاريع صغيرة") {
      filteredDataList.value = dataList
          .where((order) => order.beneficiary!.fullName == selectedValueOnDropDown)
          .toList();
    } else if (selectedValueOnDropDown == "مساعدات عينية") {
      filteredDataList.value = dataList
          .where((order) => order.beneficiary!.fullName == selectedValueOnDropDown)
          .toList();
    } else if (selectedValueOnDropDown == "مساعدات طبية") {
      filteredDataList.value = dataList
          .where((order) =>  order.beneficiary!.fullName== selectedValueOnDropDown)
          .toList();
    }
  }

  void exportToExcelWeb(List<DataModel> dataList) {
    final excel = Excel.createExcel(); // إنشاء ملف Excel
    final sheet = excel['Users'];

    // إضافة رأس الجدول
    sheet.appendRow([
      TextCellValue('الاسم'),
      TextCellValue('ID'),
      TextCellValue('الموقع'),
      TextCellValue('البريد'),
      TextCellValue('الهاتف'),
      TextCellValue('اسم المستخدم'),
    ]);

    // إضافة البيانات
    for (final data in dataList) {
      sheet.appendRow([
        TextCellValue(data.name ?? ''),
        TextCellValue(data.website ?? ''),
        TextCellValue(data.email ?? ''),
        TextCellValue(data.phone ?? ''),
        TextCellValue(data.username ?? ''),
      ]);
    }

    // تحويل الملف إلى بايتات
    final bytes = excel.encode();
    if (bytes == null) return;

    // إنشاء رابط للتنزيل
    final blob = html.Blob([Uint8List.fromList(bytes)]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "Users.xlsx")
      ..click();

    html.Url.revokeObjectUrl(url); // تنظيف الرابط
  }

  Future<void> exportToPdfWeb(List<DataModel> dataList) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Table.fromTextArray(
              headers: [
                'الاسم',
                'المعرف',
                'الموقع',
                'البريد الإلكتروني',
                'الهاتف',
                'اسم المستخدم'
              ],
              data: dataList
                  .map((data) => [
                        data.name ?? '',
                        data.id?.toString() ?? '',
                        data.website ?? '',
                        data.email ?? '',
                        data.phone ?? '',
                        data.username ?? '',
                      ])
                  .toList(),
              headerStyle: pw.TextStyle(font: ttf, fontSize: 12),
              cellStyle: pw.TextStyle(font: ttf, fontSize: 10),
              cellAlignment: pw.Alignment.centerRight,
            ),
          );
        },
      ),
    );

    final bytes = await pdf.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'data.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  void deleteRow(int index) {
    final removedItem = filteredDataList.removeAt(index);
    dataList.remove(removedItem);
    selectedRows.removeAt(index);
  }
  
}
