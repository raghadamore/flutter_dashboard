import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/bar_chart.dart';

import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/dashboard_card.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/pie_chart.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/table_dashboard/data_table_dashoard.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view_controller.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardViewController controller=DashboardViewController.instance;
    return Scaffold(
        body: Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
     return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSize.defultSpace),
          child: Obx(()=>
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ملخص اليوم:",
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(22)),
                ),
                const SizedBox(
                  height: TSize.spaceBtwSections,
                ),
                
                   Row(
                    children: [
                      Expanded(
                          child: TDashboardCard(
                        title: "مشاريع قيد المتابعة",
                       subTitle: controller.pendingProjectNumPerDay.toString(),
                        stats: 25,
                        icon: Iconsax.repeat_circle,
                      )),
                      SizedBox(
                        width: TSize.spaceBtwItems,
                      ),
                      Expanded(
                          child: TDashboardCard(
                        title: "المساعدات المرفوضة",
                          subTitle: controller.rejectedProjectNumPerDay.toString(),
                          stats: 25,
                          icon: Iconsax.close_circle,
                      )),
                    ],
                  ),
                
                SizedBox(
                  height: TSize.spaceBtwItems,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TDashboardCard(
                      title: "المستفيدين المقبولين",
                      subTitle:controller.ApprovedProjectNumPerDay.toString(),
                      stats: 25,
                      icon: Iconsax.copy_success,
                    )),
                    SizedBox(
                      width: TSize.spaceBtwItems,
                    ),
                    Expanded(
                        child: TDashboardCard(
                      title: "عدد الطلبات المسجلة",
                      subTitle: controller.allprojectsNumPerDay.toString(),
                      stats: 25,
                      icon: Iconsax.task_square,
                    )),
                  ],
                ),
                const SizedBox(
                  height: TSize.spaceBtwSections,
                ),
                TRoundedContainer(
                  
                            child: Column(
                              children: [
                                Text(
                                 "نسبة المستفيدين",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(
                                  height: TSize.spaceBtwSections,
                                ),
                                SizedBox(
                                  height: 500,
                                  child: BeneficiariesBarChart(orders: controller.orders,)),
                              ],
                            ),
                          ),
                const SizedBox(
                  height: TSize.spaceBtwSections,
                ),
                TRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الطلبات الأخيرة",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: TSize.spaceBtwSections,
                      ),
                      DashboardOrderTable(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSize.spaceBtwSections,
                ),
                SizedBox(
                  
                            
                                
                                
                                  height: 500,
                                  child: const OrderStatusPieChart(),
                              
                            
                          ),
                
              ],
            ),
          ),
        ),
      );
       }),
    );
  }
}
