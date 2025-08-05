import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/shared_widgets/headers/header.dart';

import 'package:task_P2/ui/shared/shared_widgets/sidebars/sidebar.dart';

class Mobile extends StatelessWidget {
  Mobile({super.key, this.body});
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: const TSidebare(),
      appBar: THeader(
        scaffoldkey: scaffoldkey,
      ),
      body: body ?? const SizedBox(),
    );
  }
}
