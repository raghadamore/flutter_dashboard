
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:bot_toast/bot_toast.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/data/models/beneficiary_model.dart';
import '../../../core/data/repository/beneficiary_repository.dart';

class UsersViewController extends GetxController {
  RxList<BeneficiaryModel> beneficiaries = <BeneficiaryModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  RxInt sortColumnIndex = 0.obs;
  RxBool sortAscending = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllBeneficiary();
  }

  Future<void> getAllBeneficiary() async {
    final result = await BeneficiaryRepository().getAllBeneficiary();
    result.fold(
      (l) => BotToast.showText(text: l),
      (r) {
        beneficiaries.assignAll(r);
        selectedRows.assignAll(List.generate(r.length, (_) => false));
        print("beneficiaries: $beneficiaries");
      },
    );
  }

  void sortById(int columnIndex, bool ascending) {
    if (beneficiaries.isEmpty) return;

    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    beneficiaries.sort((a, b) {
      final aValue = a.id ?? 0;
      final bValue = b.id ?? 0;
      return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    });

    selectedRows.assignAll(List.generate(beneficiaries.length, (_) => false));
  }

  void exportToExcelWeb(List<BeneficiaryModel> dataList) {
    final excel = Excel.createExcel();
    final sheet = excel['Users'];

    // Header
    sheet.appendRow([
      TextCellValue('الاسم'),
      TextCellValue('ID'),
      TextCellValue('البريد الإلكتروني'),
      TextCellValue('نوع المستخدم'),
      TextCellValue('الجنس'),
    ]);

    // Data rows
    for (final data in dataList) {
      final fullName = '${data.firstName ?? ""} ${data.lastName ?? ""}';
      sheet.appendRow([
        TextCellValue(fullName.trim()),
        TextCellValue(data.id?.toString() ?? ''),
        TextCellValue(data.email ?? ''),
        TextCellValue(data.userType ?? ''),
        TextCellValue(data.gender ?? ''),
      ]);
    }

    final bytes = excel.encode();
    if (bytes == null) return;

    final blob = html.Blob([Uint8List.fromList(bytes)]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "Users.xlsx")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

 Future<void> exportToPdfWeb(List<BeneficiaryModel> dataList) async {
  final pdf = pw.Document();

  final fontData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
  final ttf = pw.Font.ttf(fontData);

  // تجهيز رؤوس الأعمدة (من اليمين لليسار)
  final headers = [
    'الاسم',
    'المعرف',
    'البريد الإلكتروني',
    'نوع المستخدم',
    'الجنس',
  ];

  // تجهيز البيانات (مع قلب الترتيب ليتناسب مع RTL)
  final data = dataList.map((item) {
    return [
      '${item.firstName ?? ''} ${item.lastName ?? ''}',
      item.id?.toString() ?? '',
      item.email ?? '',
      item.userType ?? '',
      item.gender ?? '',
    ];
  }).toList();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Table.fromTextArray(
            headers: headers,
            data: data,
            headerStyle: pw.TextStyle(font: ttf, fontSize: 12, fontWeight: pw.FontWeight.bold),
            cellStyle: pw.TextStyle(font: ttf, fontSize: 10),
            cellAlignment: pw.Alignment.centerRight,
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey),
          ),
        );
      },
    ),
  );

  final bytes = await pdf.save();
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'Users.pdf')
    ..click();
  html.Url.revokeObjectUrl(url);
}
}