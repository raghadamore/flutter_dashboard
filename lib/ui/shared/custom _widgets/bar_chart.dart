

import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/models/order_model.dart';
import 'package:task_P2/core/data/models/project_model.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view_controller.dart';

class BeneficiariesBarChart extends StatelessWidget {
  final List<ProjectModel> orders;

  BeneficiariesBarChart({super.key, required this.orders});

  final DashboardViewController controller = DashboardViewController.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // عداد الفئات حسب البيانات المتوفرة لديك
     
      final Map<String, int> categoryCounts = {
        'مساعدة طبية': controller.medicalPeriodAll.value,
        'مساعدة مادية': controller.materialPeriodAll.value,
        'مشروع تجاري': controller.commericalPeriodAll.value,
        'مشروع زراعي': controller.AgriculturePeriodAll.value,
      };

      final total = categoryCounts.values.reduce((a, b) => a + b);
      if (total == 0) {
        return const Center(child: Text("لا يوجد بيانات مستفيدين"));
      }

      final List<fl.BarChartGroupData> barGroups = [];
      final List<String> categories = categoryCounts.keys.toList();

      for (int i = 0; i < categories.length; i++) {
        final percent = (categoryCounts[categories[i]]! / total) * 100;
        barGroups.add(
          fl.BarChartGroupData(
            x: i,
            barRods: [
              fl.BarChartRodData(
                toY: percent,
                width: 20,
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
        );
      }

      return fl.BarChart(
        fl.BarChartData(
          maxY: 100,
          barGroups: barGroups,
          titlesData: fl.FlTitlesData(
            bottomTitles: fl.AxisTitles(
              sideTitles: fl.SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  categories[value.toInt()],
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            leftTitles: fl.AxisTitles(
              sideTitles: fl.SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) => Text('${value.toInt()}%'),
              ),
            ),
          ),
          gridData: fl.FlGridData(show: true),
          borderData: fl.FlBorderData(show: false),
          barTouchData: fl.BarTouchData(enabled: true),
          alignment: fl.BarChartAlignment.spaceAround,
        ),
      );
    });
  }
}
