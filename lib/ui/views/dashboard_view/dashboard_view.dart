import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/dashboard_view/responsive_screeens/dashboard_desktop.dart';
import 'package:task_P2/ui/views/dashboard_view/responsive_screeens/dashboard_mobile.dart';
import 'package:task_P2/ui/views/dashboard_view/responsive_screeens/dashboard_tablet.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop: DashboardDesktop(),mobile: DashboardMobileScreen(),tablet: DashboardTabletScreen(),);
  }
}