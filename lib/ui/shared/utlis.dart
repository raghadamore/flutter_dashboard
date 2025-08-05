import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/repository/auth_repository.dart';
import 'package:task_P2/core/enums/order_status_enum.dart';
import 'package:task_P2/core/enums/order_type_enum.dart';

import 'package:task_P2/core/services/location_service.dart';
import 'package:task_P2/ui/views/forget_password/forget_password_controller.dart';
import 'package:task_P2/ui/views/login_view/login_controller.dart';
import 'package:task_P2/ui/shared/size.dart';
import '../../core/data/repository/shared_prefrence_repository.dart';
import '../../core/services/connectivity_service.dart';
import 'colors.dart';
import 'package:intl/intl.dart';

void customLoader() => BotToast.showCustomLoading(toastBuilder: (context) {
      return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 247, 103, 103).withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        width: screenWidth(4),
        height: screenWidth(4),
        child: SpinKitCircle(
          color: AppColors.color8,
          size: screenWidth(8),
        ),
      );
    });

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isComplexPassword(String password) {
  RegExp regex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  return regex.hasMatch(password);
}

double screenWidth(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.width / percent;
  else
    return Get.size.height / percent;
}

double screenHeight(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.height / percent;
  else
    return Get.size.width / percent;
}

Locale getLocal() {
  String langCode = storage.getAppLanguage();

  if (langCode == 'ar')
    return Locale('ar', 'SA');
  else if (langCode == 'en')
    return Locale('en', 'US');
  else
    return Locale('fr', 'FR');
}

void changeLanguage(String code) {
  storage.setAppLanguage(code);
  Get.updateLocale(getLocal());
}

SharedPrefrenceRepository get storage => Get.find<SharedPrefrenceRepository>();
ConnectivitySerivce get connectivitySerivce => Get.find<ConnectivitySerivce>();
LocationService get locationService => Get.find<LocationService>();
Connectivity get connectivity => Get.find<Connectivity>();
LoginController get login_controller=> Get.find<LoginController>();
ForgetPsswordController get forget_password_controller=> Get.find<ForgetPsswordController>();

AuthRepository get authRepository => Get.find<AuthRepository>();
bool isOnline = true;
bool isDesktopScreen(BuildContext context){
return MediaQuery.of(context).size.width>=TSize.desktopScreenSize;
}
bool isTabletScreen(BuildContext context){
return MediaQuery.of(context).size.width>=TSize.tabletScreenSize && MediaQuery.of(context).size.width<TSize.desktopScreenSize;
}
bool isMobileScreen(BuildContext context){
return MediaQuery.of(context).size.width<TSize.tabletScreenSize;
}
bool IsDarkMode(BuildContext context){
 return false;
}
 DateTime getStartOfWeek(DateTime date){
  final int daysUnitMonday=date.weekday -1;
  final DateTime startOfWeek=date.subtract(Duration(days: daysUnitMonday));
  return DateTime(startOfWeek.year,startOfWeek.month,startOfWeek.day,0,0,0,0,0);

}
Color getOrderStatusColor(OrderStatus value){
  if (OrderStatus.ACCEPTED==value) {
    return AppColors.red;
    
  }else if(OrderStatus.PENDING==value){
    return AppColors.color2;
  }
  else if(OrderStatus.REJECTED==value){
    return AppColors.color7;
  }
  else{
    return AppColors.grey;
  }

}

 Color getColorForType(String type) {
    switch (type) {
      case "مشاريع زراعية":
        return AppColors.agricaulture_project_color;
      case "مشاريع تجارية":
        return AppColors.commerical_project_color;
      case "مساعدات عينية":
        return AppColors.in_kind_color;
      case "مساعدات طبية":
        return AppColors.medical_aid_color;
      default:
        return Colors.grey;
    }
  }
 Color getColorForEvalution(String type) {
    switch (type) {
      case "نعم":
        return AppColors.secondcolor;
      case "لاء":
        return AppColors.primary;
      
      default:
        return Colors.grey;
    }
  }
String getFormattedDate(DateTime date,{String format="dd MMM yyyy"}){
  return DateFormat(format).format(date);
}