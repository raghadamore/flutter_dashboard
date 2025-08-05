import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/activitys_view/activity_view_controller.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view_controller.dart';

class ActivityTableSource extends DataTableSource {
  final controller = ActivityController.instance;
  DashboardViewController controller1=DashboardViewController.instance;
  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    final activity = controller.activities[index];
    return DataRow2(cells: [
     
      DataCell(Container(width: screenWidth(20),height: screenWidth(20), child: Image(image: MemoryImage(base64Decode(activity.imageBase64))))),
      DataCell(Text(activity.description)),
       DataCell(Text(
        activity.date.toString(),
        
      ),
      ),
      
      
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount =>controller1.lastFiveOrder.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
