import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_header_form.dart';


import 'package:task_P2/ui/shared/size.dart';

class ForgetPasswordMobile extends StatelessWidget {
  const ForgetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(TSize.defultSpace),
          child: HeaderAndForm(),
        )
      ),
    );
  }
}
