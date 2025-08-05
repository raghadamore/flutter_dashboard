import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/size.dart';

class TspacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight=EdgeInsets.only(
    top: TSize.appBarHeight,
    left: TSize.defultSpace,
    bottom: TSize.defultSpace,
    right: TSize.defultSpace,
  );
}