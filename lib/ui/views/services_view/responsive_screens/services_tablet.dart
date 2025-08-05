import 'package:flutter/cupertino.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:task_P2/core/data/models/project_model.dart';
import 'package:task_P2/core/translation/app_translation.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/data_table/table_controller.dart';
class ServicesTabletScreen extends StatelessWidget {
  const ServicesTabletScreen({super.key});

   @override
  Widget build(BuildContext context) {
    final TableController controller = Get.put(TableController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                      height: TSize.spaceBtwItems,
                    ),
                Row(
                  children: [
                    SizedBox(
                      width: TSize.spaceBtwItems,
                    ),
                    Expanded(
                        child: TRoundedContainer(
                      child: Row(
                        children: [
                          Image.asset(
                             'assets/images/pngs/eyes.png',
                           width: screenWidth(12),
                            height:screenWidth(15),
                          ),
                          //SizedBox(width: TSize.spaceBtwItems,),
                          Text("مساعدات عينية",style: TextStyle(color: AppColors.primary,fontSize: screenWidth(33)),),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: TSize.spaceBtwItems,
                    ),
                     Expanded(
                        child: TRoundedContainer(
                      child: Row(
                        children: [
                          Image.asset(
                             'assets/images/pngs/medical_aid.png',
                            width: screenWidth(12),
                            height:screenWidth(15),
                          ),
                         // SizedBox(width: TSize.spaceBtwItems,),
                          Text("مساعدات طبية",style: TextStyle(color: AppColors.primary,fontSize: screenWidth(33)),),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: TSize.spaceBtwItems,
                    ),
                     Expanded(
                        child: TRoundedContainer(
                      child: Row(
                        children: [
                          Image.asset(
                             'assets/images/pngs/small_project.png',
                            width: screenWidth(12),
                            height:screenWidth(15),
                          ),
                          //SizedBox(width: TSize.spaceBtwItems,),
                          Text(" مشاريع صغيرة",style: TextStyle(color: AppColors.primary,fontSize: screenWidth(33)),),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: TSize.spaceBtwItems,
                    )
                  ],
                ),
                SizedBox(
                      height: TSize.spaceBtwItems,
                    ),
                Row(
                  children: [
                    SizedBox(
                      width: TSize.spaceBtwItems,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: screenWidth(4),
                        child: TextFormField(
                          cursorColor: AppColors.secondcolor,
                          controller: controller.searchTextController,
                          onChanged: (query) => controller.searchQuery(query),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: "بحث",
                            prefixIcon: const Icon(Iconsax.search_normal),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.secondcolor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                     SizedBox(
                      width: TSize.spaceBtwItems,
                    ),
                    Obx(() {
                      return Container(
                        width: screenWidth(3),
                        height: screenWidth(14),
                        
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: AppColors.white),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: DropdownButton<String>(
                              dropdownColor: AppColors.secondcolor,
                              iconDisabledColor: AppColors.primary,
                              isExpanded: true,
                              menuWidth: screenWidth(5),
                              style: TextStyle(
                                fontSize: screenWidth(50),
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              underline: SizedBox(),
                              isDense: true,
                              value: controller.selectedValueOnDropDown.value,
                              items: const [
                                DropdownMenuItem(
                                  value: "كل الطلبات",
                                  child: Text("كل الطلبات",
                                      ),
                                ),
                                 DropdownMenuItem(
                                  value: "مشاريع تجارية",
                                  child: Text(
                                    "مشاريع تجارية",
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "مشاريع زراعية",
                                  child: Text(
                                    "مشاريع زراعية",
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "مساعدات طبية",
                                  child: Text("مساعدات طبية",
                                      ),
                                ),
                                DropdownMenuItem(
                                  value: "مساعدات عينية",
                                  child: Text("مساعدات عينية",
                                     ),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                controller.selectedValueOnDropDown.value =
                                    newValue!;
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: screenWidth(6),
                        height: screenWidth(18),
                        child: ElevatedButton.icon(
                          onPressed: () => controller
                              .exportToExcelWeb(controller.filteredDataList),
                          icon: Icon(
                            Icons.download,
                            color: AppColors.primary,
                          ),
                          label: Text(
                            "Excel",
                            style: TextStyle(color: AppColors.primary,fontSize: screenWidth(48)),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: screenWidth(6),
                        height: screenWidth(18),
                        child: ElevatedButton.icon(
                          onPressed: () => controller
                              .exportToPdfWeb(controller.filteredDataList),
                          icon: Icon(
                            Icons.picture_as_pdf,
                            color: AppColors.primary,
                          ),
                          label: Text(
                            "pdf",
                            style: TextStyle(color: AppColors.primary,fontSize: screenWidth(48)),
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
                            label: const Text("رقم التعريف (ID)"),
                            onSort: (index, asc) =>
                                controller.sortById(index, true),
                          ),
                          DataColumn2(label: const Text("التاريخ")),
                          DataColumn2(
                            label: const Text("الخدمة المقدمة"),
                            onSort: (index, asc) =>
                                controller.sortById(index, true),
                          ),
                          DataColumn2(
                            label: const Text("الحالة"),
                            onSort: (index, asc) =>
                                controller.sortById(index, true),
                          ),
                          DataColumn2(
                            label: const Text("رقم الهاتف"),
                            onSort: (index, asc) =>
                                controller.sortById(index, true),
                          ),
                          const DataColumn2(label: Text("")),
                        ],
                        source: MyDataTableSource(controller.filteredDataList),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final TableController controller = Get.find<TableController>();
  final List<ProjectModel> orders;
  MyDataTableSource(this.orders);
  @override
  DataRow2 getRow(int index) {
    if (index >= orders.length) return null as DataRow2;
    final data = orders[index];

    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) {
        if (value??false) {
        if (data.aidTypeDisplay=="جهاز سكري") {
            Get.toNamed(TRoutes.medicalProjectFormScreen,arguments: data.id);
          }
          else if (data.aidTypeDisplay=="مساعدات عينية") {
            Get.toNamed(TRoutes.materialProjectFormScreen,arguments: data.id);
          }
         else if (data.aidTypeDisplay=="مشروع تجاري") {
            Get.toNamed(TRoutes.businessProjectFormScreen,arguments: data.id);
          }
           else if (data.aidTypeDisplay=="مشروع زراعي") {
            Get.toNamed(TRoutes.agriculturalProjectFormScreen,arguments: data.id);
          }
          
        }
        controller.selectedRows[index] = value ?? false;
        notifyListeners();
      },
      cells: [
       
        DataCell(Text(data.beneficiary!.fullName ?? "")),
        DataCell(Text(data.id?.toString() ?? "")),
        DataCell(Text(data.requestDate ?? "")), // تاريخ وهمي، يمكن تعديله لاحقاً
        DataCell(Text(data.aidTypeDisplay ?? "")), // الخدمة المقدمة
        DataCell(Text(data.statusDisplay ?? "")), // الحالة
        DataCell(Text(data.beneficiary!.phoneNumber ?? "")),
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.red, size: 16),
            onPressed: () {
              controller.deleteRow(index);
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
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((e) => e).length;
}
