import 'package:get/get.dart';



class HomeViewController extends GetxController {
  void onInit() {
    super.onInit();
  }
  void press1(){
    Get.toNamed('/Second_view',arguments: "data is num");
}
}
