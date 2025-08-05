import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:task_P2/core/enums/connectivity_status.dart';

import 'package:task_P2/ui/shared/shared_widgets/responsive/responsive_design.dart';
import 'package:task_P2/ui/shared/shared_widgets/responsive/screens/desktop.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/app-routes.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/site_layout.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import '../core/translation/app_translation.dart';
import '../ui/views/login_view/login_controller.dart';
import '../ui/shared/shared_widgets/responsive/screens/mobile.dart';
import '../ui/shared/shared_widgets/responsive/screens/tablet.dart';
import '../ui/views/home_view/home_view.dart';
import '../ui/views/second_view/second_view.dart';

import 'my_app_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    MyAppController controller = Get.put(MyAppController());
    return StreamProvider<ConnectivityStatus>(
      create: (context) =>
          connectivitySerivce.connectivityStatusController.stream,
      initialData: ConnectivityStatus.OFFLINE,
      child: GetMaterialApp(
        getPages: TAppRoute.pages,
        initialRoute:
        //TRoutes.dashboardScreen,
        Get.find<LoginController>().isLoggingIn?TRoutes.dashboardScreen:TRoutes.login,
        unknownRoute: GetPage(
            name: '/page-not-found',
            page: () => const Scaffold(
                  body: Center(
                    child: Text("page not found"),
                  ),
                )),
                
        locale: getLocal(),
        translations: AppTranslation(),
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromRGBO(1, 171, 237, 100)),
        ),
        // قhome: HomeView()
      ),
    );
  }
}

class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  TSiteTemplate(
      desktop: Desktop(),
      mobile: Mobile(),
      tablet: Tablet(),
    );
  }
}
