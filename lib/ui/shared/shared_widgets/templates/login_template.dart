import 'package:flutter/cupertino.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/spacing_styles.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class TLoginTemplate extends StatelessWidget {
  const TLoginTemplate({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Container(
            padding: TspacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSize.cardRadiusLg),
              color: IsDarkMode(context)? AppColors.black :AppColors.white,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}