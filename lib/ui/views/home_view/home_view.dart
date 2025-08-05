import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/home_view/home_view_controller.dart';

class HomeView extends StatelessWidget {
  
  const HomeView({super.key});

  @override
  
  Widget build(BuildContext context) {
    HomeViewController controller=Get.put(HomeViewController());
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: screenWidth(1.5),
            child: ElevatedButton(onPressed:() {
               controller.press1();
            },  child: Text("press me")),
          ),
        ],
      ),
    );
  }
}
