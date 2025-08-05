import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/user_account_managment/responsive_screens/user_account_view_desktop.dart';
import 'package:task_P2/ui/views/user_account_managment/responsive_screens/user_account_view_mobile.dart';
import 'package:task_P2/ui/views/user_account_managment/responsive_screens/user_account_view_tablet.dart';
class UserAccountManagmentView extends StatelessWidget {
  const UserAccountManagmentView({super.key});

  @override
  Widget build(BuildContext context) {
     return TSiteTemplate(desktop: UserAccountViewDesktop(),tablet: UserAccountViewTablet(),mobile: UserAccountViewMobile(),);
  }
}