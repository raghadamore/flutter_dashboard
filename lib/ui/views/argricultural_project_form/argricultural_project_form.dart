import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/argricultural_project_form/responsive_screens/argricultural_project_desktop.dart';
import 'package:task_P2/ui/views/argricultural_project_form/responsive_screens/argricultural_project_mobile.dart';
import 'package:task_P2/ui/views/argricultural_project_form/responsive_screens/argricultural_project_tablet.dart';



class ArgriculturalProjectForm extends StatelessWidget {
  const ArgriculturalProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:ArgriculturalProjectDesktop (),mobile: ArgriculturalProjectMobile(),tablet:ArgriculturalProjectTablet (),);
  }
}