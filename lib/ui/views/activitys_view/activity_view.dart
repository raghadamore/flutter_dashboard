import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/activitys_view/responsive_screens/activity_view_desktop.dart';
import 'package:task_P2/ui/views/activitys_view/responsive_screens/activity_view_mobile.dart';
import 'package:task_P2/ui/views/activitys_view/responsive_screens/activity_view_tablet.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: ActivityViewDesktop(),tablet: ActivityViewTablet(),mobile: ActivityViewMobile(),);
  }
}