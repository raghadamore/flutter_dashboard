import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:task_P2/ui/shared/custom%20_widgets/custom_login_header.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_login_form.dart';



class LoginViewMobile extends StatelessWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSize.defultSpace),
          child: Column(
            children: [
              TLoginHeader(),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
