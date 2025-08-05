import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/enums/order_status_enum.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view_controller.dart';


class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =DashboardViewController .instance;

    return TRoundedContainer(
      child: SingleChildScrollView(  // لاحظ هنا 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "التقرير الشهري",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSize.spaceBtwSections),
            Obx(() {
              if (controller.percentages.isEmpty) {
               
                return const Text("لا توجد بيانات لهذا الشهر");
              }
print("PieChart Data: ${controller.percentages}");

              return Column(
                children: [
                  SizedBox(
                    height: 260, // حجم الدائرة فقط
                    child: PieChart(
                      PieChartData(
                        
                        sections: controller.percentages.entries.map((entry) {
                          return PieChartSectionData(
                            title: "${entry.value.toStringAsFixed(1)}%",
                            value: entry.value,
                            radius: 50,
                            color: getColorForType(entry.key),
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          );
                        }).toList(),
                        pieTouchData: PieTouchData(enabled: true),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.percentages.keys.map((type) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getColorForType(type),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(type, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}