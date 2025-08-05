import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_P2/app/my_app.dart';
import 'package:task_P2/core/data/repository/auth_repository.dart';
import 'package:task_P2/core/data/repository/shared_prefrence_repository.dart';
import 'package:task_P2/core/services/connectivity_service.dart';
import 'package:task_P2/core/services/location_service.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/data_table/table_controller.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/table_news/table_source.dart';
import 'package:task_P2/ui/views/argricultural_project_form/argricultural_project_form_controller.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view_controller.dart';
import 'package:task_P2/ui/views/evaluation/evalution_view.dart';
import 'package:task_P2/ui/views/evaluation/evalution_view_controller.dart';
import 'package:task_P2/ui/views/forget_password/forget_password_controller.dart';
import 'package:task_P2/ui/views/login_view/login_controller.dart';
import 'package:task_P2/ui/views/medical_project_form/medical_project_form_controller.dart';
import 'package:task_P2/ui/views/news_view/news_view_controlller.dart';
import 'package:task_P2/ui/views/reports_view/reports_view_controller.dart';
import 'package:task_P2/ui/views/business_project_form/business_project_form_controller.dart';
import 'package:task_P2/ui/views/services_view/services_view_controller.dart';
import 'package:task_P2/ui/views/user_account_managment/user_account_managment_view_controller.dart';
import 'package:task_P2/ui/views/verify_code_view/verify_code_controller.dart';
import 'package:url_strategy/url_strategy.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();

  Get.put<SharedPreferences>(prefs);
  Get.put(SharedPrefrenceRepository());

  // 1. سجل الكنترولر أولاً
  final newsController = Get.put(NewsViewControlller());

  // 2. جهز مصدر البيانات newsTableSource مع الكنترولر مباشرة
  newsController.newsTableSource = NewsRows(controller: newsController);
   Get.create(() => MedicalProjectFormController());

  // لاحظ أنك لا تحتاج استدعاء هذا مرتين أو استخدام lazyPut لنفس الأشياء التي وضعتها بالفعل:
  // Get.lazyPut(() => SharedPrefrenceRepository());  <-- زائدة هنا
 Get.put(ForgetPsswordController(),permanent: true );
   Get.lazyPut(() => MedicalProjectFormController());

  Get.put(LoginController());
   Get.lazyPut(() => ServicesViewController());
  Get.put(DashboardViewController());
  Get.put(ReportsViewController());
     Get.lazyPut(() => ServicesViewController());
  Get.lazyPut(() => MedicalProjectFormController());

 Get.create(() => BusinessProjectFormController());
  Get.put(ConnectivitySerivce());
  Get.put(LocationService());
  Get.put(Connectivity());
    Get.lazyPut(() => ServicesViewController());
  Get.put(EvalutionViewController());
 Get.put(() => BusinessProjectFormController());
  Get.lazyPut(() => AuthRepository());
  Get.lazyPut(() => UserAccountManagmentViewController());
  Get.lazyPut(() => TableController());
  Get.lazyPut(() => BusinessProjectFormController());
  Get.lazyPut(() => ArgriculturalProjectFormController());
 
 
 
 
  Get.create(() => VerifyCodeController(),);

  runApp(const MyApp());
}