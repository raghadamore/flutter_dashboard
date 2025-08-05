import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/business_project_form/responsive_screeens/business_project_desktop.dart';
import 'package:task_P2/ui/views/business_project_form/responsive_screeens/business_project_mobile.dart';
import 'package:task_P2/ui/views/business_project_form/responsive_screeens/business_project_tablet.dart';


class BusinessProjectForm extends StatelessWidget {
  const BusinessProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:BusinessProjectDesktop (),mobile: BusinessProjectMobile(),tablet:BusinessProjectTablet (),);
  }
}