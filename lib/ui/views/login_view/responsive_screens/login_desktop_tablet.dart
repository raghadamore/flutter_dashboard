import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:task_P2/ui/shared/custom%20_widgets/custom_login_header.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/login_template.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_login_form.dart';

class LoginViewDesktop extends StatelessWidget {
  const LoginViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return TLoginTemplate(
        child: const Column(
      children: [
        TLoginHeader(),
        LoginForm(),
      ],
    ));
  }
}
