import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_reset_password_widget.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/login_template.dart';


class ResetPasswordDesktopTablet extends StatelessWidget {
  const ResetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    
    return TLoginTemplate(
        child: ResetPasswordWidget());
  }
}


