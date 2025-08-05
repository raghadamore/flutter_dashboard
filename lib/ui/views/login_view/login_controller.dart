import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/repository/auth_repository.dart';
import 'package:task_P2/core/data/repository/shared_prefrence_repository.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/home_view/home_view.dart';

class LoginController extends GetxController {
    static LoginController get instance=>Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool obscureText = true.obs;
  bool isLoggingIn = false;
  RxBool isChecked = false.obs;
  RxString username="".obs;

  RxString role="".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    rememberMe();
    super.onInit();
     changeLanguage("ar");
  }

  void login() {
    // CommonResponse c1 =
    //     CommonResponse(data: '', message: '', statusCode: 1);

    //  CommonResponse c2 = CommonResponse.fromJson({});
    if (!isOnline) {
      BotToast.showText(text: 'Please check internet connection');
      return;
    }

    //* Api Request -----

    isLoading.value = true;

    AuthRepository()
        .login(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      isLoading.value = false;

      value.fold((l) {
        BotToast.showText(text: l);
      }, (r) {
        storage.setTokenInfo(r.access!);
        storage.setRefreshTokenInfo(r.refresh!);
        storage.setLogedIn(true);
        
        isLoggingIn = true;
        setUserDetial(r.firstName!,r.lastName!,r.profilePicture?? "",r.userType!);
        username.value=r.firstName!+" "+r.lastName!;
       // image_profile=r.profilePicture as RxString?;
        if (isChecked.value) {
          storage.setLoginInfo([emailController.text, passwordController.text]);
        }
        Get.offAllNamed(TRoutes.dashboardScreen);
       
      });
    });
  }

  void rememberMe() {
    Get.put(SharedPrefrenceRepository());
    if (storage.getLoginInfo().isNotEmpty) {
      isChecked.value = true;
      emailController.text = storage.getLoginInfo()[0];
      passwordController.text = storage.getLoginInfo()[1];
    } else {
      emailController.text = '';
      passwordController.text = '';
    }
  }

  void setUserDetial(String fname,String lname,String image,String employee) {
    username.value="$fname $lname";
  //  image_profile?.value=image ;
    role.value=employee;
   
  }
  void logout() {
    //the repo logout
    storage.setLogedIn(false);
    isLoggingIn = false;
  }

  void changeLanguage(String code) {
    storage.setAppLanguage(code);
    Get.updateLocale(getLocal());
  }
}
