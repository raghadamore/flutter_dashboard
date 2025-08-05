import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/models/activity_model.dart';


class ActivityController extends GetxController {
  static ActivityController get instance=>Get.find();
  final activities = <Activity>[
    
  ].obs;
  final descController = TextEditingController();
  DateTime? selectedDate;
  Uint8List? imageBase64;

  void pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate = picked;
      update();
    }
  }

  void pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      imageBase64 =result.files.single.bytes!;
      update();
    }
  }

  void addActivity() {
    if (imageBase64 != null && selectedDate != null && descController.text.isNotEmpty) {
      activities.add(Activity(
        imageBase64:base64Encode(imageBase64!),
        date: selectedDate!,
        description: descController.text,
      ));
      // Reset
      descController.clear();
      selectedDate = null;
      imageBase64 = null;
      update();
    }
  }
}