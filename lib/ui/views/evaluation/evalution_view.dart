import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/evaluation/responsive_screen/evalution_desktop.dart';
import 'package:task_P2/ui/views/evaluation/responsive_screen/evalution_mobile.dart';
import 'package:task_P2/ui/views/evaluation/responsive_screen/evalution_tablet.dart';

class EvalutionView extends StatelessWidget {
  const EvalutionView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: EvalitionViewDesktop(),mobile: EvalutionViewMobile(),tablet: EvalutionViewTablet(),);
  }
}