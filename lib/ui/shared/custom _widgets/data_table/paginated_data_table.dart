import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/views/services_view/responsive_screens/services_desktop.dart';

class TPaginatedDataTable extends StatelessWidget {
  const TPaginatedDataTable(
      {super.key,
      this.sortAscending = true,
      this.sortColumnIndex,
      this.rowsPerPage = 10,
      required this.source,
      required this.columns,
      this.onPageChanged,
      this.tableHeight = 760,
      this.minWidth = 1000,
      this.dataRowHeight = TSize.xl * 2});
  final bool sortAscending;
  final int? sortColumnIndex;
  final int rowsPerPage;
  final DataTableSource source;
  final List<DataColumn> columns;
  final Function(int)? onPageChanged;
  final double dataRowHeight;
  final double tableHeight;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tableHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
          cardTheme: const CardTheme(
            color: AppColors.white,
            elevation: 0,
          ),
        ),
        child: PaginatedDataTable2(
          showCheckboxColumn: true,
          onPageChanged: onPageChanged,
          columnSpacing: 12,
          minWidth: minWidth,
          dividerThickness: 0,
          horizontalMargin: 12,
          dataRowHeight: dataRowHeight,
          rowsPerPage: rowsPerPage,
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          headingRowColor:
              WidgetStateColor.resolveWith((states) => AppColors.secondcolor),
          showFirstLastButtons: true,
          renderEmptyRowsInTheEnd: false,
          sortAscending: sortAscending,
          sortColumnIndex: sortColumnIndex,
          sortArrowAlwaysVisible: true,
          onRowsPerPageChanged: (noOfRows) {},
          sortArrowIcon: Icons.line_axis,
          columns: columns,
          source: source,
        ),
      ),
    );
    ;
  }
}
