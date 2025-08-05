import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/reports_view/responsive_screens/reports_desktop.dart';
import 'package:task_P2/ui/views/reports_view/responsive_screens/reports_mobile.dart';
import 'package:task_P2/ui/views/reports_view/responsive_screens/reports_tablet.dart';


class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:ReportsDesktopScreen (),mobile: ReportsMobileScreen(),tablet:ReportsTabletScreen (),);
  }
}