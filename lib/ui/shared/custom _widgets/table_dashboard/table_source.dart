import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view_controller.dart';

class OrderRows extends DataTableSource {
  final DashboardViewController controller = DashboardViewController.instance;

  OrderRows() {
    // استمع لأي تغيير في قائمة الطلبات
    controller.lastFiveOrder.listen((_) {
      notifyListeners();
    });
  }

  @override
  DataRow? getRow(int index) {
    final order = controller.lastFiveOrder[index];
    return DataRow2(
      cells: [
        DataCell(Text(order.beneficiary!.fullName!)),
        DataCell(Text(order.requestDate.toString())),
        DataCell(Text(
          order.id.toString(),
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge!
              .apply(color: AppColors.primary),
        )),
        DataCell(Text(order.statusDisplay.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.lastFiveOrder.length;

  @override
  int get selectedRowCount => 0;
}
