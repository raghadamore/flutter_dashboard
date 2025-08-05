import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom _widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/business_project_form/business_project_form_controller.dart';

class ArgriculturalProjectTablet extends StatelessWidget {
  const ArgriculturalProjectTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BusinessProjectFormController.instance;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(() {
          final detail = controller.detailsProject.value;

          if (detail == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // المعلومات الشخصية
                buildDataSection(
                  title: "المعلومات الشخصية",
                  constraints: constraints,
                  columns: const [
                    DataColumn(label: Text("الاسم الثلاثي")),
                    DataColumn(label: Text("البريد الالكتروني")),
                    DataColumn(label: Text("تاريخ الميلاد")),
                    DataColumn(label: Text("الجنس")),
                    DataColumn(label: Text("رقم الهاتف")),
                    DataColumn(label: Text("العنوان السابق")),
                    DataColumn(label: Text("العنوان الحالي")),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(detail.beneficiary?.fullName ?? "")),
                      DataCell(Text(detail.beneficiary?.email ?? "")),
                      DataCell(Text(detail.beneficiary?.birthDate ?? "")),
                      DataCell(Text(detail.beneficiary?.gender ?? "")),
                      DataCell(Text(detail.beneficiary?.phoneNumber ?? "")),
                      DataCell(Text(detail.beneficiary?.previousAddress ?? "")),
                      DataCell(Text(detail.beneficiary?.currentAddress ?? "")),
                    ]),
                  ],
                ),

                // التفاصيل الاجتماعية
                buildDataSection(
                  title: "تفاصيل اجتماعية",
                  constraints: constraints,
                  columns: const [
                    DataColumn(label: Text("التحصيل العلمي")),
                    DataColumn(label: Text("عدد أفراد الأسرة")),
                    DataColumn(label: Text("العمل الحالي")),
                    DataColumn(label: Text("الحالة الاجتماعية")),
                    DataColumn(label: Text("نقاط ضعف /إعاقة")),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(detail.beneficiary?.education ?? "")),
                      DataCell(Text(detail.beneficiary?.familyMembers.toString() ?? "")),
                      DataCell(Text(detail.beneficiary?.job ?? "")),
                      DataCell(Text(detail.beneficiary?.maritalStatus ?? "")),
                      DataCell(Text(detail.beneficiary?.weaknessesDisabilities ?? "")),
                    ]),
                  ],
                ),

                // التفاصيل الاقتصادية
                TRoundedContainer(
                  margin: const EdgeInsets.all(10),
                  width: screenWidth(0.6),
                  height: screenWidth(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("تفاصيل اقتصادية", style: TextStyle(color: AppColors.primary, fontSize: screenWidth(28))),
                      const SizedBox(height: TSize.spaceBtwItems),
                      buildBulletRow("هل تملك أرض زراعية؟", detail.ownership ?? ""),
                      const SizedBox(height: TSize.lg),
                      buildBulletRow("هل لديك خبرة زراعية سابقة؟", detail.experience ?? ""),
                      const SizedBox(height: TSize.lg),
                      buildBulletRow("هل تملك أدوات:", detail.tools ?? ""),
                      const SizedBox(height: TSize.lg),
                      const Text("الملاحظات:", style: TextStyle(color: AppColors.black)),
                      Text(detail.notes ?? "", style: const TextStyle(color: AppColors.black)),
                    ],
                  ),
                ),

                const SizedBox(height: TSize.spaceBtwSections),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     buildDecisionButton("قبول",(){
                      controller.patchCommericalProject(controller.index,"approved","2025-10-20");
                     
                       // الرجوع
                    }),
                    const SizedBox(width: TSize.spaceBtwItems),
                    buildDecisionButton("رفض",(){
                      controller.patchCommericalProject(controller.index,"rejected","2025-10-20");
                       
                    }),
                  ],
                ),
                const SizedBox(height: TSize.spaceBtwSections),
              ],
            ),
          );
        });
      },
    );
  }

  Widget buildDataSection({
    required String title,
    required BoxConstraints constraints,
    required List<DataColumn> columns,
    required List<DataRow> rows,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TRoundedContainer(
            margin: const EdgeInsets.all(10),
            width: screenWidth(0.6),
            height: screenWidth(2.6),
            child: Column(
              children: [
                Text(title, style: TextStyle(color: AppColors.primary, fontSize: screenWidth(28))),
                const SizedBox(height: TSize.spaceBtwItems),
                Container(
                  width: screenWidth(0.65),
                  height: screenWidth(5),
                  decoration: BoxDecoration(color: AppColors.white, border: Border.all(color: AppColors.black)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                      child: DataTable2(
                        minWidth: 1000,
                        columnSpacing: 20,
                        headingRowColor: const WidgetStatePropertyAll(AppColors.secondcolor),
                        columns: columns,
                        rows: rows,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBulletRow(String title, String value) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(title, style: TextStyle(color: AppColors.black, fontSize: screenWidth(35))),
        Flexible(child: Text(value, style: TextStyle(color: AppColors.black, fontSize: screenWidth(35)))),
      ],
    );
  }

  Widget buildDecisionButton(String text,VoidCallback? onpressed){
    return SizedBox(
      width: screenWidth(6),
      height: screenWidth(14),
      child: ElevatedButton(
        onPressed: onpressed ??(){},
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondcolor),
        child: Text(text, style: const TextStyle(color: AppColors.black)),
      ),
    );
  }
}
