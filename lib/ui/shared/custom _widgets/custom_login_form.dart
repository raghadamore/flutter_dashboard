import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/translation/app_translation.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/views/login_view/login_controller.dart';

import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/text_strings.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginController controller = LoginController.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: TSize.spaceBtwSections,
        ),
        child: Column(children: [
          TextFormField(
            cursorColor: AppColors.secondcolor,
            controller: controller.emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: AppColors.primary),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondcolor)),
                hintStyle: TextStyle(color: AppColors.secondcolor),
                labelText: tr("البريد الالكتروني"),
                labelStyle: TextStyle(color: AppColors.secondcolor),
                focusColor: AppColors.secondcolor),
            validator: (value) {
              //!--- value => usernameController.text
              if (value!.isEmpty)
                return " ادخل بريد الكتروني";
              else if (!isEmailValid(value)) return "من فضلك ادخل بريد الكتروني صحيح";
            },
          ),
          const SizedBox(
            height: TSize.spaceBtwInputFields,
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
                labelText: tr("كلمة المرور"),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Obx(() {
                    return Checkbox(
                      checkColor: AppColors.secondcolor,
                      value: controller.isChecked.value,
                      onChanged: (bool? value) {
                        controller.isChecked.value = value!;
                      },
                    );
                  }),
                  Text(tr("تذكرني"))
                ],
              ),
              TextButton(
                onPressed: () => Get.toNamed(TRoutes.forgetPassword),
                child:  Text(
                  tr("هل نسيت كلمة المرور؟"),
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSize.spaceBtwSections,
          ),
          Obx(() {
            return controller.isLoading.value
                ? SpinKitCircle(
                    color: AppColors.primary,
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            controller.login();
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.secondcolor)),
                        child: Text(tr("تسجيل الدخول"),style: TextStyle(color: AppColors.black),)),
                  );
          }),
        ]),
      ),
    );
  }
}
