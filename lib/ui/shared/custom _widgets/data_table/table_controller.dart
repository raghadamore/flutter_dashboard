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
import 'package:task_P2/core/data/repository/agricultural_repository.dart';
import 'package:task_P2/core/data/repository/commerical_repository.dart';
import 'package:task_P2/core/data/repository/data_table_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:task_P2/core/data/models/data_model.dart';
import 'package:task_P2/core/data/repository/material_repository.dart';
import 'package:task_P2/core/data/repository/medical_repository.dart';
import 'package:task_P2/core/data/repository/project_repository.dart';

class TableController extends GetxController {
   static TableController get instance=>Get.find();
  RxList<ProjectModel> dataList = <ProjectModel>[].obs;
  RxList<ProjectModel> filteredDataList = <ProjectModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  RxString selectedValueOnDropDown = "كل الطلبات".obs;
  RxInt sortColumnIndex = 0.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController();
 final RxBool shouldRefresh = false.obs;
  RxList<ProjectModel> medicalPending = <ProjectModel>[].obs;
  RxList<ProjectModel> medicalApprovid = <ProjectModel>[].obs;
  RxList<ProjectModel> medicalRejected = <ProjectModel>[].obs;
  RxList<ProjectModel> allMedicalProjects = <ProjectModel>[].obs;

  RxList<ProjectModel> materialPending = <ProjectModel>[].obs;
  RxList<ProjectModel> materialApprovid = <ProjectModel>[].obs;
  RxList<ProjectModel> materialRejected = <ProjectModel>[].obs;
  RxList<ProjectModel> allMaterialProjects = <ProjectModel>[].obs;

  RxList<ProjectModel> commericalPending = <ProjectModel>[].obs;
  RxList<ProjectModel> commericalApprovid = <ProjectModel>[].obs;
  RxList<ProjectModel> commericalRejected = <ProjectModel>[].obs;
  RxList<ProjectModel> allCommericalProjects = <ProjectModel>[].obs;

  RxList<ProjectModel> agriculturePending = <ProjectModel>[].obs;
  RxList<ProjectModel> agricultureApprovid = <ProjectModel>[].obs;
  RxList<ProjectModel> agricultureRejected = <ProjectModel>[].obs;
  RxList<ProjectModel> allAgricultureProjects = <ProjectModel>[].obs;


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
    getAllMedicalProjects();
    getAllMaterialProjects();
    getAllCommericalProjects();
    getAllAgricultureProjects();
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
          item.beneficiary!.fullName ?? "",
          item.id,
          item.requestDate,
          item.aidTypeDisplay,
          item.category,
          item.beneficiary!.phoneNumber,
        ].any((value) =>
            value?.toString().toLowerCase().contains(lowerQuery) ?? false);
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
Future<void> getMedicalProjectsByStatus(String status) async {
  final result = await MedicalRepository().getAllMedicalProject(status: status);
  result.fold(
    (l) => BotToast.showText(text: l),
    (r) {
      if (status=="pending") {
        medicalPending.assignAll(r);
      }else if(status=="approved"){
        medicalApprovid.assignAll(r);
      }else{
        medicalRejected.assignAll(r);
      }
      
      
    },
  );
}
void getAllMedicalProjects(){
  getMedicalProjectsByStatus("pending");
  getMedicalProjectsByStatus("approved");
  getMedicalProjectsByStatus("rejected");
  allMedicalProjects.value=medicalPending+medicalApprovid+medicalRejected;

}
Future<void> getMaterialProjectsByStatus(String status) async {
  final result = await MaterialRepository().getAllMaterialProject(status: status);
  result.fold(
    (l) => BotToast.showText(text: l),
    (r) {
      if (status=="pending") {
        materialPending.assignAll(r);
      }else if(status=="approved"){
        materialApprovid.assignAll(r);
      }else{
        materialRejected.assignAll(r);
      }
      
      
    },
  );
}
void getAllMaterialProjects(){
  getMaterialProjectsByStatus("pending");
  getMaterialProjectsByStatus("approved");
  getMaterialProjectsByStatus("rejected");
  allMaterialProjects.value=materialPending+materialApprovid+materialRejected;

}
Future<void> getCommericalProjectsByStatus(String status) async {
  final result = await CommericalRepository().getAllCommericalProject(status: status);
  result.fold(
    (l) => BotToast.showText(text: l),
    (r) {
      if (status=="pending") {
        commericalPending.assignAll(r);
      }else if(status=="approved"){
        commericalApprovid.assignAll(r);
      }else{
        commericalRejected.assignAll(r);
      }
      
      
    },
  );
}
void getAllCommericalProjects(){
  getCommericalProjectsByStatus("pending");
  getCommericalProjectsByStatus("approved");
  getCommericalProjectsByStatus("rejected");
  allCommericalProjects.value=commericalPending+commericalApprovid+commericalRejected;

}
Future<void> getAgricultureProjectsByStatus(String status) async {
  final result = await AgriculturalRepository().getAllAgricultureProject(status: status);
  result.fold(
    (l) => BotToast.showText(text: l),
    (r) {
      if (status=="pending") {
        agriculturePending.assignAll(r);
      }else if(status=="approved"){
        agricultureApprovid.assignAll(r);
      }else{
        agricultureRejected.assignAll(r);
      }
      
      
    },
  );
}
void getAllAgricultureProjects(){
  getAgricultureProjectsByStatus("pending");
  getAgricultureProjectsByStatus("approved");
  getAgricultureProjectsByStatus("rejected");
  allAgricultureProjects.value=agriculturePending+agricultureApprovid+agricultureRejected;

}

  void filterOrders() {
    //عدل username الئ status
    if (selectedValueOnDropDown == "كل الطلبات") {
      filteredDataList.value = dataList;
    } else if (selectedValueOnDropDown == "مشاريع تجارية") {
      filteredDataList.value = allCommericalProjects;
         
         
    } else if(selectedValueOnDropDown == "مشاريع زراعية"){
  filteredDataList.value = allAgricultureProjects;
          
    
   } else if (selectedValueOnDropDown == "مساعدات عينية") {
      filteredDataList.value = allMaterialProjects;
          
    } else if (selectedValueOnDropDown == "مساعدات طبية") {
      filteredDataList.value = allMedicalProjects;
          
    }
  }

  void exportToExcelWeb(List<ProjectModel> dataList) {
    final excel = Excel.createExcel(); // إنشاء ملف Excel
    final sheet = excel['Users'];

    // إضافة رأس الجدول
    sheet.appendRow([
      TextCellValue('الاسم'),
      TextCellValue('ID'),
      TextCellValue('التاريخ'),
      TextCellValue('الخدمة المقدمة'),
      TextCellValue('الحالة'),
      TextCellValue('رقم الهاتف'),
    ]);

    // إضافة البيانات
    for (final data in dataList) {
      sheet.appendRow([
        TextCellValue(
          data.beneficiary!.fullName ?? '',
        ),
        TextCellValue(
          data.id?.toString() ?? '',
        ),
        TextCellValue(
          data.requestDate ?? '',
        ),
        TextCellValue(
          data.aidTypeDisplay ?? '',
        ),
        TextCellValue(
          data.statusDisplay ?? '',
        ),
        TextCellValue(
          data.beneficiary!.phoneNumber ?? '',
        ),
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

  Future<void> exportToPdfWeb(List<ProjectModel> dataList) async {
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
                'التاريخ',
                'الخدمة المقدمة',
                'الحالة',
                'رقم الهاتف'
              ],
              data: dataList
                  .map((data) => [
                        data.beneficiary!.fullName ?? '',
                        data.id?.toString() ?? '',
                        data.requestDate ?? '',
                        data.aidTypeDisplay ?? '',
                        data.statusDisplay ?? '',
                        data.beneficiary!.phoneNumber ?? '',
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
