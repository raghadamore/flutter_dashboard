import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/repository/auth_repository.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class ForgetPsswordController extends GetxController {
  static ForgetPsswordController get instance => Get.find();
  final emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool obscureText = true.obs;

  RxBool isLoading = false.obs;
  var recoveryEmail = "".obs;
  final verificationCode = "".obs;
  void setRecoveryEmail(String email) {
    recoveryEmail.value = email;
  }

  String get getRecoveryEmail => recoveryEmail.value;
  void setVerificationCode(String code) {
    verificationCode.value = code.trim();
  }

  String get getVerificationCode => verificationCode.value;
  void forgetPassword() {
    AuthRepository()
        .forgetPassword(email: recoveryEmail.toString())
        .then((value) {
      isLoading.value = false;

      value.fold((l) {
        BotToast.showText(text: l);
      }, (r) {
        BotToast.showText(text: r.message!);

        Get.offAllNamed(TRoutes.verifyCodeScreen);
      });
    });
  }

  void confirmOtp() {
    AuthRepository()
        .confirmOTP(email: getRecoveryEmail, otp: getVerificationCode)
        .then((value) {
      isLoading.value = false;

      value.fold((l) {
        BotToast.showText(text: l);
      }, (r) {
        BotToast.showText(text: r.message!);

        Get.offAllNamed(TRoutes.resetPassword);
      });
    });
  }

  void resetPassword() {
    AuthRepository()
        .resetPassword(
            email: getRecoveryEmail,
            otp: getVerificationCode,
            newPassword: passwordController.text,
            confirmPassword: confirmPasswordController.text)
        .then((value) {
      isLoading.value = false;

      value.fold((l) {
        BotToast.showText(text: l);
      }, (r) {
        BotToast.showText(text: r.message!);

        Get.offAllNamed(TRoutes.login);
      });
    });
  }
  void logout()async{
 print(storage.getRefreshTokenInfo());

 await AuthRepository().logout(refresh: storage.getRefreshTokenInfo()).then((value) {
      isLoading.value = false;

      value.fold((l) {
        BotToast.showText(text: l);
      }, (r) {
        BotToast.showText(text: r.message!);

         storage.clearTokens();
      Get.offAllNamed(TRoutes.login);
      });
    });
  }




}
