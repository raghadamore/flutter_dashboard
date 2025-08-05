import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';

import 'package:task_P2/ui/views/users_view/responsive_screens/users_desktop.dart';
import 'package:task_P2/ui/views/users_view/responsive_screens/users_mobile.dart';
import 'package:task_P2/ui/views/users_view/responsive_screens/users_tablet.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:UsersDesktopScreen (),mobile: UsersMobileScreen(),tablet:UsersTabletScreen (),);
  }
}