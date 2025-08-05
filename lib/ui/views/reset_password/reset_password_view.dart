import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:task_P2/ui/views/reset_password/responsive_screens/reset_password_mobile.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(useLayout: false,desktop: ResetPasswordDesktopTablet(),mobile: ResetPasswordMobile(),);
  }
}