import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task_P2/core/enums/image_type_enum.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/image_strings.dart';
import 'package:task_P2/ui/shared/shared_widgets/image_uploader.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldkey});

  final GlobalKey<ScaffoldState>? scaffoldkey;

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(bottom: BorderSide(color: AppColors.grey, width: 1))),
      child: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: !isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldkey?.currentState?.openDrawer(),
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.secondcolor,
                ),
              )
            : null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // اليسار: شعار + SSSD (يظهر فقط على سطح المكتب)
            Row(
              children: [
                if (!isMobileScreen(context))
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Obx(() {
                        
                        return Column(
                          children: [
                            Text(
                              login_controller.username.value,
                              style: Theme.of(context).textTheme.titleLarge,
                              selectionColor: AppColors.black,
                            ),
                            Text(
                        login_controller.role.toString(),
                        style: Theme.of(context).textTheme.labelMedium,
                        selectionColor: AppColors.darkGray,
                      ),
                          ],
                        );
                      }),
                      
                      
                    ],
                  ),
              //  Obx(() {
                 // return Padding(
                  //  padding: const EdgeInsets.only(right: 50),
                    ///child: TRoundedImage(
                     // imageType: ImageType.NETWORK,
                      //width: 30,
                     // height: 35,
                      //padding: 2,
                     // image: login_controller.image_profile?.value ?? "https://i.stack.imgur.com/l60Hf.png",
                   // ),
                 // );
               // }),
                const SizedBox(width: TSize.sm),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: AppColors.secondcolor,
                    )),
              ],
            ),

            // الوسط: اسم الجمعية
            Expanded(
              child: Center(
                child: Text(
                  "الجمعية السورية للتنمية الاجتماعية",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: !isMobileScreen(context) ? 20 : 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Text(
                  "SSSD",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: !isMobileScreen(context) ? 20 : 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: !isMobileScreen(context) ? 20 : 10,
                ),
                Image(
                  width: !isMobileScreen(context) ? 50 : 20,
                  height: !isMobileScreen(context) ? 50 : 20,
                  image: AssetImage(TImage.LightAppLLogo),
                ),
                const SizedBox(width: 8),
              ],
            ),
            // اليمين: صورة المستخدم واسم المستخدم
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
