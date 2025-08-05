import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
  
import 'package:get/get.dart';
import 'package:task_P2/core/data/models/activity_model.dart';
  
import 'package:task_P2/core/data/models/new_model.dart';
  
import 'package:task_P2/ui/shared/custom%20_widgets/table_news/table_source.dart';
  

  
class NewsViewControlller extends GetxController {
  
  static NewsViewControlller get instance => Get.find();
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

  
  late NewsRows newsTableSource;
  

  
  RxList<NewsModel> news = <NewsModel>[
  
    NewsModel(
  
      newsDetails: "نص تجريبي طويل لعرض تفاصيل الخبر بشكل جيد",
  
      publishingDate: DateTime(2025, 4, 6),
  
      status: "منشور",
  
    ),
  
    NewsModel(
  
      newsDetails: "مقبول",
  
      publishingDate: DateTime(2025, 6, 8),
  
      status: "غير منشور",
  
    ),
  
  ].obs;
  

  
  var titleController = TextEditingController();
  
  var detailsController = TextEditingController();
  
  
  
  var isAdding = false.obs;
  

  
  @override
  
  void onInit() {
  
    super.onInit();
  
   
  
  }
  
  @override
  
void onReady() {
  
  newsTableSource = NewsRows(controller: this);
  
  super.onReady();
  
}
  

  
  void startAdding() {
  
    isAdding.value = true;
  
    titleController.clear();
  
    detailsController.clear();
  
    selectedDate = DateTime.now();
  
    newsTableSource.notifyListeners();
  
  }
  

  
  void cancelAdding() {
  
    isAdding.value = false;
  
    newsTableSource.notifyListeners();
  
  }
  

  
  void saveNews() {
  
    if (detailsController.text.trim().isEmpty) return;
  

  
    news.insert(
  
      0,
  
      NewsModel(
  
        newsDetails: detailsController.text.trim(),
  
        publishingDate: selectedDate!,
  
        status: "جديد",
  
      ),
  
    );
  
    isAdding.value = false;
  
    newsTableSource.notifyListeners();
  
  }
  

  
  void deleteNews(int index) {
  
    if (index >= 0 && index < news.length) {
  
      news.removeAt(index);
  
      newsTableSource.notifyListeners();
  
    }
  
  }
  

  
  void editNews(int index, NewsModel newItem) {
  
    if (index >= 0 && index < news.length) {
  
      news[index] = newItem;
  
      newsTableSource.notifyListeners();
  
    }
  
  }
  
}