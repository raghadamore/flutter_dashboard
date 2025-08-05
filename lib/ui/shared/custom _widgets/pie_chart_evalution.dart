import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/enums/order_status_enum.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view_controller.dart';
import 'package:task_P2/ui/views/evaluation/evalution_view_controller.dart';


class EvalutionPieChart extends StatelessWidget {
   EvalutionPieChart({super.key,required this.result,required this.getColor,this.height,this.radius});
RxMap<String, int> result;
Function getColor;
double? height;
double? radius;
  @override
  Widget build(BuildContext context) {
    final controller =EvalutionViewController .instance;
    
    return SingleChildScrollView(  // لاحظ هنا 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
         
          Obx(() {
            if (result.isEmpty) {
              return const Text("لا توجد بيانات");
            }
    
            return Column(
              children: [
                SizedBox(
                  height:height??  250, // حجم الدائرة فقط
                  child: PieChart(
                    PieChartData(
                      
                      sections: result.entries.map((entry) {
                        return PieChartSectionData(
                          value: entry.value.toDouble(),
                          radius:radius?? 200,
                          title: "",
                          color: getColorForEvalution(entry.key),
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        );
                      }).toList(),
                      sectionsSpace: 0,
                      pieTouchData: PieTouchData(enabled: true),
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: result.keys.map((type) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: getColor(type),
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
    );
  }
}