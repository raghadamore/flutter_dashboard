import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/views/material_project_form/responsive_screens/material_project_desktop.dart';
import 'package:task_P2/ui/views/material_project_form/responsive_screens/material_project_mobile.dart';
import 'package:task_P2/ui/views/material_project_form/responsive_screens/material_project_tablet.dart';

import 'package:task_P2/ui/views/medical_project_form/responsive_screens/medical_project_desktop.dart';
import 'package:task_P2/ui/views/medical_project_form/responsive_screens/medical_project_mobile.dart';
import 'package:task_P2/ui/views/medical_project_form/responsive_screens/medical_project_tablet.dart';



class MaterialProjectForm extends StatelessWidget {
  const MaterialProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(desktop:MaterialProjectDesktop (),mobile: MaterialProjectMobile(),tablet:MaterialProjectTablet (),);
  }
}