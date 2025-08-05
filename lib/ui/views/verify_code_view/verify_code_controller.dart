import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/views/forget_password/forget_password_controller.dart';

class VerifyCodeController extends GetxController {
  static VerifyCodeController get instance=>Get.find();
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes =
      List.generate(4, (index) => FocusNode());
@override
void onInit() {
    // TODO: implement onInit
    super.onInit();
    focusNodes[0].requestFocus();
  }  
  void onChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      Future.delayed(const Duration(milliseconds: 50), () {
        focusNodes[index + 1].requestFocus();
      });
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }    
}