




import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom _widgets/dashboard_card.dart';
import 'package:task_P2/ui/shared/custom _widgets/pie_chart.dart';
import 'package:task_P2/ui/shared/custom _widgets/pie_chart_monthly.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/line_chart_monthly.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/reports_view/reports_view_controller.dart';
import '../../../shared/custom _widgets/custom_rounded_container.dart';

class ReportsTabletScreen extends StatefulWidget {
  const ReportsTabletScreen({super.key});

  @override
  State<ReportsTabletScreen> createState() => _ReportsTabletScreenState();
}

class _ReportsTabletScreenState extends State<ReportsTabletScreen> {
  final GlobalKey _globalKey = GlobalKey();
  final controller = ReportsViewController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey,
          child: _buildContent(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: exportToPdf,
        child: Icon(Icons.picture_as_pdf),
      ),
    );
  }

  Widget _buildContent() {
    return  Obx(()=>
       SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(height: TSize.spaceBtwItems,),
              Row(
                children: [
                 SizedBox(width: TSize.spaceBtwItems,),
                  TRoundedContainer(
                    width: screenWidth(4),
                    height: screenWidth(2.8),
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                  
                        Image.asset(
                          'assets/images/pngs/report_icons.png',
                          width: 105,
                          height: 80,
                        ),
                        SizedBox(
                          height: TSize.spaceBtwItems,
                        ),
                        Text(
                          "عدد الطلبات \n المقبولة",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(28)),
                        ),
                        SizedBox(
                          height: TSize.spaceBtwItems,
                        ),
                        Text(
                         controller.allProjectApprovidNum.value.toString(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(30)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: TSize.spaceBtwSections,),
                  TRoundedContainer(
                    width: screenWidth(4),
                    height: screenWidth(2.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/pngs/accept_order.png',
                          width: 105,
                          height: 80,
                        ),
                        SizedBox(
                          height: TSize.spaceBtwItems,
                        ),
                        Text(
                          "عدد الطلبات \n الكلية",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(28)),
                        ),
                        SizedBox(
                          height: TSize.spaceBtwItems,
                        ),
                        Text(
                        controller.allProjectNum.value.toString(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(30)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: TSize.spaceBtwSections,),
                  TRoundedContainer(
                    width: screenWidth(4),
                    height: screenWidth(2.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/pngs/reject_order.png',
                          width: 105,
                          height: 80,
      
      
      ),
                        SizedBox(
                          height: TSize.spaceBtwItems,
                        ),
                        Text(
                          "عدد الطلبات \n المرفوضة",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(28)),
                        ),
                        SizedBox(
                          height: TSize.spaceBtwItems,
                        ),
                        Text(
                         controller.allProjectRejectedNum.value.toString(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(30)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: TSize.spaceBtwSections,),
             Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // ⭐ يجعلهم يبدأون من نفس المستوى
            children: [
              SizedBox(width: TSize.spaceBtwItems),
      
              // Pie Chart
              Expanded(
                child: SizedBox(height: 550, child: OrderStatusMonthlyPieChart()),
              ),
      
              SizedBox(width: TSize.spaceBtwItems),
              
      
              // Line Chart
              Expanded(
                flex: 2,
                child: TRoundedContainer(
                  height: 550, // ⭐ نفس الارتفاع بالضبط
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "عدد الطلبات المقبولة شهرياً",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        // ⭐ حتى يمتد داخل TRoundedContainer
                        child: AcceptedOrdersLineChart(
                          orders: ReportsViewController.orders,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      
              SizedBox(width: TSize.spaceBtwItems),
            ],
          )
            ],
          ),
        ),
    );
  }

  Future<void> exportToPdf() async {
  try {
    // عرض مؤشر التحميل
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: Row(
          children: const [
            Icon(Icons.picture_as_pdf, color: Colors.red, size: 30),
            SizedBox(width: 16),
            Text("جاري تصدير التقرير...", style: TextStyle(fontSize: 16)),
            SizedBox(width: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );

    await Future.delayed(Duration(milliseconds: 150));
    await WidgetsBinding.instance.endOfFrame;

    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 1.8);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final pdf = pw.Document();

    // تحميل الشعار
    final logoBytes = await rootBundle.load('assets/images/pngs/logo.png');
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    // التاريخ الحالي
    final now = DateTime.now();
    final formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final screenshotImage = pw.MemoryImage(pngBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header: شعار وتاريخ
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logoImage, width: 70), // شعار الجمعية
                  pw.Text(
                    "$formattedDate",
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),

              // الصورة المأخوذة من الشاشة
              pw.Expanded(
                child: pw.Center(child: pw.Image(screenshotImage)),
              ),
            ],
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();

    // تحميل الملف على الويب
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "report.pdf")
      ..click();
    html.Url.revokeObjectUrl(url);

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text("تم تصدير التقرير بنجاح!"),
          ],
        ),
      ),
    );
  } catch (e) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(width: 10),
            Text("حدث خطأ أثناء التصدير: $e"),
          ],
        ),
      ),
    );
  }
}

}
