import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/activity_table.dart/activity_table_source.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/data_table/paginated_data_table.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/table_dashboard/table_source.dart';
import 'package:task_P2/ui/shared/size.dart';

class ActivityTable extends StatelessWidget {
  const ActivityTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
     minWidth: 700,
     tableHeight: 300,
     dataRowHeight: TSize.xl*1.2, 
      source: ActivityTableSource(),
       columns:const[
        DataColumn2(label: Text("الصورة")),
        DataColumn2(label: Text("تفاصيل الخبر")),
       
        DataColumn2(label: Text("تاريخ النشر")),
        
      ] );
  }
}