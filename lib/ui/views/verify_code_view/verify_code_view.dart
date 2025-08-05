import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/verify_code_view/responsive_screens/verify_code_desktop_tablet.dart';
import 'package:task_P2/ui/views/verify_code_view/responsive_screens/verify_code_mobile.dart';


class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(useLayout: false,desktop: VerifyCodeDesktopTablet(),mobile: VerifyCodeMobile(),);
  }
}