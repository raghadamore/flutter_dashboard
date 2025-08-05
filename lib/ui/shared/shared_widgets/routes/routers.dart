import 'package:task_P2/app/my_app.dart';
import 'package:task_P2/ui/views/second_view/second_view.dart';

class TRoutes {
  static const firstScreen = '/';
  static const SecondScreen = '/Second_view';
  static const ResponsiveDesignScreen = '/responsive-design-view';
  static const login = '/login_view';
  static const forgetPassword = '/forger_password_view/';
  static const resetPassword = '/reset_password_view';
  static const dashboardScreen = '/dashboard_view';
  static const reportsScreen = '/reports_view';
  static const usersScreen = '/users_view';
  static const servicesScreen = '/services_view';
  static const newsScreen = '/news_view';
  static const businessProjectFormScreen = '/business_project_form_view';
  static const EvalutionScreen = '/evalution_view';
  static const userAccountManagmentScreen = '/user_account_managment_view';
  static const agriculturalProjectFormScreen ='/agricultural_project_form_view';
  static const medicalProjectFormScreen ='/medical_project_form_view';
  static const materialProjectFormScreen ='/material_project_form_view';
  static const activityScreen ='/activity_view';
  static const verifyCodeScreen ='/VerifyCode_view';
  static const logout ='/logout';
  

  static List sideBarMenuItems = [
    firstScreen,
    ResponsiveDesignScreen,
  ];
}
