import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';

import 'package:task_P2/ui/views/login_view/responsive_screens/login_desktop_tablet.dart';
import 'package:task_P2/ui/views/login_view/responsive_screens/login_mobile.dart';
import 'package:task_P2/ui/views/login_view/responsive_screens/login_tablet.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      useLayout: false,
      desktop: LoginViewDesktop(),
      mobile: LoginViewMobile(),
      tablet: LoginViewTablet(),
    );
  }
}
