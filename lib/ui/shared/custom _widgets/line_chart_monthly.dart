import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/core/data/models/order_model.dart';
import 'package:task_P2/ui/views/reports_view/reports_view_controller.dart';

class AcceptedOrdersLineChart extends StatelessWidget {
  final List<OrderModel> orders;

  const AcceptedOrdersLineChart({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final controller = ReportsViewController.instance;
    final monthlyAcceptedOrders = controller.getAcceptedOrdersPerMonth(orders);

    return AspectRatio(
      aspectRatio: 1.6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              horizontalInterval: 1,
              verticalInterval: 1,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1, // عرض كل الشهور
                  reservedSize: 36,
                  getTitlesWidget: (value, meta) {
                    final months = [
                      "Jan",
                      "Feb",
                      "Mar",
                      "Apr",
                      "May",
                      "Jun",
                      "Jul",
                      "Aug",
                      "Sep",
                      "Oct",
                      "Nov",
                      "Dec"
                    ];
                    if (value.toInt() >= 0 && value.toInt() < months.length) {
                      return Transform.rotate(
                        angle: -0.5, // تدوير النص لتوفير المساحة
                        child: Text(
                          months[value.toInt()],
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) => Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  monthlyAcceptedOrders.length,
                  (i) =>
                      FlSpot(i.toDouble(), monthlyAcceptedOrders[i].toDouble()),
                ),
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                dotData: FlDotData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
