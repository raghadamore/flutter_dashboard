import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/responsive/responsive_design.dart';
import 'package:task_P2/ui/shared/shared_widgets/responsive/screens/desktop.dart';
import 'package:task_P2/ui/shared/shared_widgets/responsive/screens/mobile.dart';
import 'package:task_P2/ui/shared/shared_widgets/responsive/screens/tablet.dart';

class TSiteTemplate extends StatelessWidget {
  const TSiteTemplate({super.key, this.desktop, this.tablet, this.mobile,  this.useLayout=true});
  
  final Widget? desktop;

  final Widget? tablet;

  final Widget? mobile;
  final bool useLayout; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TResponsiveWidget(
          desktop:useLayout? Desktop(body: desktop): desktop??Container(),
           tablet: useLayout? Tablet(body: tablet ?? desktop): tablet?? desktop?? Container(),
            mobile:useLayout? Mobile(body: mobile ?? desktop): mobile?? desktop?? Container(),
            ),
    );
  }
}
