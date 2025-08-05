import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/shared_widgets/sidebars/sidebar_controller.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });
  final String route;
  final IconData icon;
  final String itemName;
  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    return InkWell(
      onTap: ()  {
  if (route == "logout") {
     forget_password_controller.logout(); // ← نفذ تسجيل الخروج
  } else {
    menuController.menuOnTap(route); // ← انتقل للمسار العادي
  }
},
       
      onHover: (hovering) => hovering
          ? menuController.changeHoverItem(route)
          : menuController.changeHoverItem(""),
      child: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(vertical: TSize.xs),
          child: Container(
            decoration: BoxDecoration(
                color: menuController.isHovering(route) ||
                        menuController.isActive(route)
                    ? AppColors.primary
                    : AppColors.tranparent,
                borderRadius: BorderRadius.circular(TSize.cardRadiusMd)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: TSize.lg,
                      top: TSize.md,
                      bottom: TSize.md,
                      right: TSize.md),
                  child: menuController.isActive(route)
                      ? Icon(
                          icon,
                          size: 22,
                          color: AppColors.white,
                        )
                      : Icon(
                          icon,
                          size: 22,
                          color: menuController.isHovering(route)
                              ? AppColors.white
                              : AppColors.darkGray,
                        ),
                ),
                if (menuController.isHovering(route) ||
                    menuController.isActive(route))
                  Flexible(
                      child: Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: AppColors.white),
                  ))
                else
                  Flexible(
                      child: Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: AppColors.darkGray),
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
