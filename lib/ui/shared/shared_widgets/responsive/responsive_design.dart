import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_P2/ui/shared/size.dart';


class TResponsiveWidget extends StatelessWidget {
  const TResponsiveWidget(
      {super.key,
      required this.desktop,
      required this.tablet,
      required this.mobile});
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, Constraints) {
      if (Constraints.maxWidth >= TSize.desktopScreenSize) {
        return desktop;
      } else if (Constraints.maxWidth < TSize.desktopScreenSize && Constraints.maxWidth >= TSize.tabletScreenSize) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
