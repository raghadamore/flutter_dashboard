import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';

import 'package:task_P2/ui/views/services_view/responsive_screens/services_desktop.dart';
import 'package:task_P2/ui/views/services_view/responsive_screens/services_mobile.dart';
import 'package:task_P2/ui/views/services_view/responsive_screens/services_tablet.dart';


class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:ServicesDesktopScreen (),mobile:ServicesMobileScreen (),tablet:ServicesTabletScreen (),);
  }
}