import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_P2/app/my_app.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routes-middleware.dart';
import 'package:task_P2/ui/views/activitys_view/activity_view.dart';
import 'package:task_P2/ui/views/argricultural_project_form/argricultural_project_form.dart';
import 'package:task_P2/ui/views/dashboard_view/dashboard_view.dart';
import 'package:task_P2/ui/views/evaluation/evalution_view.dart';
import 'package:task_P2/ui/views/forget_password/forget_password_view.dart';
import 'package:task_P2/ui/views/material_project_form/material_project_form.dart';
import 'package:task_P2/ui/views/medical_project_form/medical_project_form.dart';
import 'package:task_P2/ui/views/news_view/news_view.dart';
import 'package:task_P2/ui/views/reports_view/reports_view.dart';
import 'package:task_P2/ui/views/reset_password/reset_password_view.dart';

import 'package:task_P2/ui/views/second_view/second_view.dart';
import 'package:task_P2/ui/views/services_view/services_view.dart';
import 'package:task_P2/ui/views/user_account_managment/user_account_managment_view.dart';
import 'package:task_P2/ui/views/users_view/users_view.dart';
import 'package:task_P2/ui/views/verify_code_view/verify_code_view.dart';

import '../../../views/home_view/home_view.dart';
import '../../../views/login_view/login_view.dart';
import '../../../views/business_project_form/business_project_form.dart';

class TAppRoute {
  static final List<GetPage<dynamic>> pages = [
    GetPage(
        name: TRoutes.firstScreen,
        page: () => const HomeView(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.SecondScreen,
        page: () => const SecondView(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.ResponsiveDesignScreen,
        page: () => const ResponsiveDesignScreen()),
    GetPage(name: TRoutes.login, page: () => const LoginView()),
    GetPage(
        name: TRoutes.SecondScreen,
        page: () => const SecondView(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordView()),
    GetPage(name: TRoutes.resetPassword, page: () => const ResetPasswordView()),
    GetPage(name: TRoutes.dashboardScreen, page: () => const DashboardView()),
    GetPage(name: TRoutes.servicesScreen, page: () => const ServicesView()),
    GetPage(name: TRoutes.usersScreen, page: () => const UsersView()),
    GetPage(name: TRoutes.reportsScreen, page: () => const ReportsView()),
    GetPage(name: TRoutes.newsScreen, page: () => const NewsView()),
    GetPage(name: TRoutes.businessProjectFormScreen, page: () => const BusinessProjectForm()),
    GetPage(name: TRoutes.EvalutionScreen, page: () => const EvalutionView()),
    GetPage(name: TRoutes.userAccountManagmentScreen, page: () => const UserAccountManagmentView()),
    GetPage(name: TRoutes.agriculturalProjectFormScreen, page: () => const ArgriculturalProjectForm()),
    GetPage(name: TRoutes.medicalProjectFormScreen, page: () => const MedicalProjectForm()),
    GetPage(name: TRoutes.materialProjectFormScreen, page: () => const MaterialProjectForm()),
    GetPage(name: TRoutes.activityScreen, page: () => const ActivityView()),
    GetPage(name: TRoutes.verifyCodeScreen, page: () => const VerifyCodeView()),
  ];
}
