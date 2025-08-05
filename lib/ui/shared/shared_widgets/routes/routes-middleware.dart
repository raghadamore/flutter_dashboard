import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';

import 'package:task_P2/ui/views/second_view/second_view.dart';

import '../../../views/login_view/login_controller.dart';

class TRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // TODO: implement redirect
   bool th=true;
    return th
        ? null
        : const RouteSettings(name: TRoutes.login);
  }
}
