import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer(
      {super.key,
      this.child,
      this.width=400,
       this.radius=400,
      this.height=400,
       this.showborder=false,
       this.borderColor=AppColors.primary,
       this.backgroundColor=AppColors.white,
      this.margin,
      this.padding});
  final Widget? child;
  final double? width;
  final double radius;
  final double? height;
  final bool showborder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showborder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
