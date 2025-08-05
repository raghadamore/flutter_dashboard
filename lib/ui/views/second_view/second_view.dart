import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class SecondView extends StatelessWidget {
  const SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              child: Text(
            Get.arguments ?? "",
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.colorChallenge1),
          )),
        ],
      ),
    );
  }
}
