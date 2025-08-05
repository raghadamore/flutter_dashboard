
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:task_P2/core/translation/app_translation.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/data_table/table_controller.dart';
import 'package:task_P2/ui/views/users_view/users_view_controller.dart';

class UsersMobileScreen extends StatefulWidget {
  const UsersMobileScreen({super.key});

  @override
  State<UsersMobileScreen> createState() => _UsersDesktopScreenState();
}

class _UsersDesktopScreenState extends State<UsersMobileScreen> {
  @override
  Widget build(BuildContext context) {
    final TableController controller = Get.put(TableController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: screenWidth(5),
                      height: screenWidth(15),
                      child: ElevatedButton.icon(
                        onPressed: () => controller
                            .exportToExcelWeb(controller.filteredDataList),
                        icon: Icon(
                          Icons.download,
                          color: AppColors.primary,
                        ),
                        label: Text(
                          "Excel",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(40)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: screenWidth(5),
                      height: screenWidth(15),
                      child: ElevatedButton.icon(
                        onPressed: () => controller
                            .exportToPdfWeb(controller.filteredDataList),
                        icon: Icon(
                          Icons.picture_as_pdf,
                          color: AppColors.primary,
                        ),
                        label: Text(
                          "pdf",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth(40)),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white),
                      ),
                    ),
                  )
                ],
              ),
              // const SizedBox(height: TSize.spaceBtwSections),
              Obx(() {
                return SizedBox(
                  height: 500,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      cardTheme: const CardTheme(
                        color: AppColors.white,
                        elevation: 0,
                      ),
                    ),
                    child: PaginatedDataTable2(
                      key: ValueKey(controller.filteredDataList.length),
                      showCheckboxColumn: true,
                      columnSpacing: 12,
                      minWidth: 786,
                      dividerThickness: 0,
                      horizontalMargin: 12,
                      dataRowHeight: 56,
                      rowsPerPage: 10,
                      headingTextStyle: Theme.of(context).textTheme.titleMedium,
                      headingRowColor: WidgetStateColor.resolveWith(
                          (states) => AppColors.secondcolor),
                      showFirstLastButtons: true,
                      renderEmptyRowsInTheEnd: false,
                      sortAscending: controller.sortAscending.value,
                      sortColumnIndex: controller.sortColumnIndex.value,
                      sortArrowAlwaysVisible: true,
                      sortArrowIcon: Icons.line_axis,
                      sortArrowBuilder: (ascending, sorted) {
                        if (sorted) {
                          return Icon(
                            ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                            size: TSize.iconsSm,
                          );
                        } else {
                          return const Icon(
                            Iconsax.arrow_3,
                            size: TSize.iconsSm,
                          );
                        }
                      },
                      columns: [
                        DataColumn2(label: const Text("الاسم")),
                        DataColumn2(
                          label: const Text("المعرف"),
                          onSort: (index, asc) =>
                              controller.sortById(index, true),
                        ),
                        DataColumn2(label: const Text("البريد الالكتروني")),
                        DataColumn2(
                          label: const Text("نوع المستخدم"),
                          onSort: (index, asc) =>
                              controller.sortById(index, true),
                        ),
                        DataColumn2(
                          label: const Text("الجنس"),
                          onSort: (index, asc) =>
                              controller.sortById(index, true),
                        ),
                         const DataColumn2(label: Text("")),
                      ],
                      source: MyDataTableSource(),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final UsersViewController controller = Get.find<UsersViewController>();

  @override
  DataRow2 getRow(int index) {
    if (index >= controller.beneficiaries.length) return null as DataRow2;
    final data = controller.beneficiaries[index];

    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) {
        controller.selectedRows[index] = value ?? false;
        notifyListeners();
      },
      cells: [
        DataCell(Text(data.firstName ?? "" + " " + (data.lastName ?? ""))),
        DataCell(Text(data.id?.toString() ?? "")),
        DataCell(Text(data.email ?? "")), // تاريخ وهمي، يمكن تعديله لاحقاً
        DataCell(Text(data.userType ?? "")), // الخدمة المقدمة
        DataCell(Text(data.gender ?? "")), // الحالة

        DataCell(
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.red, size: 16),
            onPressed: () {
              //controller.deleteRow(index);
              notifyListeners();
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.beneficiaries.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((e) => e).length;
}
