import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/models/userAcount_model.dart';

class UserAccountManagmentViewController extends GetxController {
   static UserAccountManagmentViewController get instance=>Get.find();
   var users=<UserAccountModel>[
    UserAccountModel(name: "ahmad", email: "amjad", password: "1234"),
    UserAccountModel(name: "ahmawd", email: "amjadamot@gmil.com", password: "1234"),
    UserAccountModel(name: "frgk", email: "knvf", password: "1234"),
    UserAccountModel(name: "mnbb", email: "rrr", password: "1234"),
    UserAccountModel(name: "llll", email: "iii", password: "1234"),
    UserAccountModel(name: "mmm", email: "jjj", password: "1234"),
   ].obs;
   var addingNewUser = false.obs;

TextEditingController nameCtrl = TextEditingController();
TextEditingController emailCtrl = TextEditingController();
TextEditingController passCtrl = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void addUser(UserAccountModel user){
    users.add(user);
  }
  void deleteUser(int index){
    users.removeAt(index);
  }

}