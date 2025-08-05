import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/data_table/paginated_data_table.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/table_news/table_source.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/views/news_view/news_view_controlller.dart';

class NewsTable extends StatelessWidget {
  const NewsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NewsViewControlller.instance;

    return  TPaginatedDataTable(
          minWidth: 700,
          tableHeight: 300,
          dataRowHeight:150,
          source: NewsRows(controller: controller), // ✅ ثابت ومراقب
          columns:  [
            DataColumn2(label: Text("تفاصيل الخبر"),fixedWidth: 700,),
            DataColumn2(label: Text("تاريخ النشر")),
            DataColumn2(label: Text("الحالة")),
            DataColumn2(label: Text("إجراءات")),
          ],
        );
  }
}
