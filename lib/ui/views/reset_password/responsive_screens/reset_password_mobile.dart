import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:task_P2/ui/shared/custom%20_widgets/custom_reset_password_widget.dart';
import 'package:task_P2/ui/shared/size.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSize.defultSpace),
          child:ResetPasswordWidget()
        ),
      ),
    );
  }
}
