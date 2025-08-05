import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:task_P2/core/translation/app_translation.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/image_strings.dart';
import 'package:task_P2/ui/shared/shared_widgets/image_uploader.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/shared_widgets/sidebars/menu/menu_item.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/reports_view/reports_view.dart';

class TSidebare extends StatelessWidget {
  const TSidebare({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(right: BorderSide(color: AppColors.grey, width: 1))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TRoundedImage(
                width: 100,
                height: 100,
                image: TImage.darkAppLLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              Padding(
                padding: EdgeInsets.all(TSize.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tr("القائمة"),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(letterSpacing: 1.2),
                    ),
                    TMenuItem(
                      icon: Icons.home_filled,
                      itemName: "الصفحة الرئيسية",
                      route: TRoutes.dashboardScreen,
                    ),
                    TMenuItem(
                      icon: Icons.people,
                      itemName: "المستخدمين",
                      route: TRoutes.usersScreen,
                    ),
                    TMenuItem(
                      icon: Icons.miscellaneous_services_outlined,
                      itemName: "الخدمات",
                      route: TRoutes.servicesScreen,
                    ),
                    TMenuItem(
                      icon: Icons.assessment,
                      itemName: "التقارير",
                      route: TRoutes.reportsScreen,
                    ),
                    TMenuItem(
                      icon: Iconsax.star_slash,
                      itemName: "التقييم",
                      route: TRoutes.EvalutionScreen,
                    ),
                    
                    TMenuItem(
                      icon: Icons.newspaper,
                      itemName: "إدارة الأخبار",
                      route: TRoutes.newsScreen,
                    ),
                    TMenuItem(
                      icon: Icons.volunteer_activism,
                      itemName: "إدارة الأنشطة",
                      route: TRoutes.activityScreen,
                    ),
                    login_controller.role=="admin"?
                    TMenuItem(
                      icon: Icons.person_add_rounded,
                      itemName: "إدارة المستخدمين",
                      route: TRoutes.userAccountManagmentScreen,
                    ):SizedBox(),
                   
                    SizedBox(
                      height: 10,
                    ),
                    TMenuItem(
                      icon: Icons.logout,
                      itemName: "تسجيل الخروج",
                      
                      
                      route: "logout",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
