import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/headers/header.dart';

import 'package:task_P2/ui/shared/shared_widgets/sidebars/sidebar.dart';

class Desktop extends StatelessWidget {
  Desktop({super.key, this.body});
  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        body: Row(
          children: [
            Expanded(child: TSidebare()),
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    THeader(),
                    Expanded(child: body ?? const SizedBox()),
                  ],
                )),
          ],
        ));
  }
}
