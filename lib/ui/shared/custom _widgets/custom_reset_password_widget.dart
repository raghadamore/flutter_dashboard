import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_P2/core/translation/app_translation.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/image_strings.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/text_strings.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/forget_password/forget_password_controller.dart';
import 'package:task_P2/ui/views/login_view/login_controller.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ForgetPsswordController controller=ForgetPsswordController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () => Get.offAllNamed(TRoutes.login),
                icon: const Icon(CupertinoIcons.clear,color: AppColors.primary,)),
          ],
        ),
        const SizedBox(
          height: TSize.spaceBtwItems,
        ),
       
        Text(
          TTexts.changeYourPasswordTitle,
          style: TextStyle(fontSize:screenWidth(28) ,color: AppColors.black)
         
        ),
         const SizedBox(
                  height: TSize.spaceBtwItems,
                ),
                
               
                Text(
                  TTexts.changeYourPasswordSubTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth(35),color: AppColors.black)
                ),
      
        SizedBox(
          height: screenWidth(18),
        ),
         Obx(
            () => TextFormField(
              cursorColor: AppColors.secondcolor,
              obscureText: controller.obscureText.value,
              controller: controller.passwordController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondcolor)),
                prefixIcon: Icon(Icons.key, color: AppColors.primary),
                labelText: tr("كلمة المرور الجديدة"),
                labelStyle: TextStyle(color: AppColors.secondcolor),
                fillColor: AppColors.primary,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.obscureText.value =
                        !controller.obscureText.value;
                  },
                  icon: Icon(
                      controller.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.primary),
                ),
              ),
              validator: (value) {
                if (!isComplexPassword(value!))
                  return "كلمة المرور خاطئة";
              },
            ),
          ),
          const SizedBox(
            height: TSize.spaceBtwInputFields / 2,
          ),
           Obx(
            () => TextFormField(
              cursorColor: AppColors.secondcolor,
              obscureText: controller.obscureText.value,
              controller: controller.confirmPasswordController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondcolor)),
                prefixIcon: Icon(Icons.key, color: AppColors.primary),
                labelText: tr("تأكيد كلمة المرور"),
                labelStyle: TextStyle(color: AppColors.secondcolor),
                fillColor: AppColors.primary,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.obscureText.value =
                        !controller.obscureText.value;
                  },
                  icon: Icon(
                      controller.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.primary),
                ),
              ),
              validator: (value) {
                if (!isComplexPassword(value!))
                  return "كلمة المرور خاطئة";
              },
            ),
          ),
          SizedBox(
          height: screenWidth(7),
        ),
        const SizedBox(
          height: TSize.spaceBtwItems,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () =>controller.resetPassword(),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColors.secondcolor)),
              child: Text(TTexts.save,style: TextStyle(color: AppColors.black),)),
        ),
        const SizedBox(
          height: TSize.spaceBtwItems,
        ),
       
      ],
    );
  }
}
