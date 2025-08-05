import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/forget_password/responsive_screens/forget_password_desktop_tablet.dart';
import 'package:task_P2/ui/views/forget_password/responsive_screens/forget_password_mobile.dart';
class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false,desktop: ForgetPasswordDesktopTablet(),mobile: ForgetPasswordMobile(),);
  }
}