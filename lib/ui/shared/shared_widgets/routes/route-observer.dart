import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/shared_widgets/sidebars/sidebar_controller.dart';

import 'package:task_P2/ui/views/second_view/second_view.dart';

class RouteObservers extends GetObserver{
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    // TODO: implement didPop
    final sidebarController=Get.put(SidebarController());
    if (previousRoute != null) {
      for (var routeName in TRoutes.sideBarMenuItems) {
        if (previousRoute.settings.name==routeName) {
          sidebarController.activeItem.value=routeName;
        }
        
      }
    }
  }
  @override
  void didPush(Route route, Route? previousRoute) {
    // TODO: implement didPush
    super.didPush(route, previousRoute);
  }
}
