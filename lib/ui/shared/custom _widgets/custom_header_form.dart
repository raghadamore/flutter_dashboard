import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/text_strings.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/forget_password/forget_password_controller.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ForgetPsswordController controller=ForgetPsswordController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       IconButton(
            onPressed: () => Get.offAllNamed(TRoutes.login), icon: const Icon(Icons.arrow_back,textDirection: TextDirection.ltr,color: AppColors.primary,)),
        const SizedBox(
          height: TSize.spaceBtwItems,
        ),
        Text(
          TTexts.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSize.spaceBtwItems,
        ),
        Text(
          TTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: TSize.spaceBtwSections * 2),
        Form(
          child:TextFormField(
            cursorColor: AppColors.secondcolor,
            controller:controller.emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: AppColors.primary),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondcolor)),
                hintStyle: TextStyle(color: AppColors.secondcolor),
                labelText: TTexts.email,
                labelStyle: TextStyle(color: AppColors.secondcolor),
                focusColor: AppColors.secondcolor),
            validator: (value) {
              //!--- value => usernameController.text
              if (value!.isEmpty)
                return "Please enter email";
              else if (!isEmailValid(value)) return "Please enter Valid email";
            },
          ),
        ),
        const SizedBox(
          height: TSize.spaceBtwSections,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                final email=controller.emailController.text.trim();
                controller.setRecoveryEmail(email);
                controller.forgetPassword();
               
                } ,
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColors.secondcolor)),
              child: Text(TTexts.submit,style: TextStyle(color: AppColors.black),)),
        ),
        const SizedBox(
          height: TSize.spaceBtwSections,
        ),
      ],
    );
  }
}
