import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/size.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer(
      {super.key,
      this.child,
      this.redius = TSize.cardRadiusLg,
      this.width,
      this.height,
      this.showBorder = false,
      this.shoeShadow = true,
      this.borderColor = AppColors.secondcolor,
      this.margin,
      this.padding = const EdgeInsets.all(TSize.md),
      this.backgroundColor = AppColors.white,
      this.onTap});
  final Widget? child;
  final double redius;
  final double? width;
  final double? height;
  final bool showBorder;
  final bool shoeShadow;
  final Color borderColor;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(redius),
          border: showBorder?Border.all(color: borderColor):null,
          boxShadow: [
            if(shoeShadow)
            BoxShadow(
              color: AppColors.grey,
              spreadRadius: 5,
              blurRadius: 8,
              offset: const Offset(0, 3)
            )
          ]
          
        ),
        child: child,
      ),
    );
  }
}
