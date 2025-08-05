import 'package:flutter/material.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading(
      {super.key, this.textColor, this.rightSideWidget, required this.title});
  final Color? textColor;
  final Widget? rightSideWidget;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:TextStyle(fontSize: screenWidth(31),color: textColor,),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (rightSideWidget != null) rightSideWidget!
      ],
    );
  }
}
