import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/views/news_view/news_view_controlller.dart';
import 'package:task_P2/ui/shared/colors.dart';

class NewsRows extends DataTableSource {
  final NewsViewControlller controller;

  NewsRows({required this.controller});

  @override
  DataRow? getRow(int index) {
    final isAdding = controller.isAdding.value;

    if (isAdding && index == 0) {
      return DataRow(cells: [
        DataCell(
          TextField(
            controller: controller.detailsController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "تفاصيل الخبر",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              Obx(() => Text(
                  controller.selectedDate.toString().split(' ')[0])),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: Get.context!,
                    initialDate: controller.selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    controller.selectedDate = picked;
                  }
                },
              )
            ],
          ),
        ),
        const DataCell(Text("جديد")),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  controller.saveNews();
                  notifyListeners(); // تحديث الجدول
                },
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  controller.cancelAdding();
                  notifyListeners();
                },
              ),
            ],
          ),
        ),
      ]);
    }

    final actualIndex = isAdding ? index - 1 : index;
    if (actualIndex >= controller.news.length) return null;

    final news = controller.news[actualIndex];
    return DataRow2(cells: [
      DataCell(Text(news.newsDetails, maxLines: 5)),
      DataCell(Text(news.publishingDate.toString().split(' ')[0])),
      DataCell(Text(news.status)),
      DataCell(
        Row(
          children: [
            const Icon(Icons.edit_document, color: AppColors.primary),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: "تأكيد الحذف",
                  middleText: "هل أنت متأكد من حذف هذا الخبر؟",
                  textConfirm: "نعم",
                  textCancel: "إلغاء",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.deleteNews(actualIndex);
                    Get.back();
                    notifyListeners();
                  },
                );
              },
              child: const Icon(Icons.delete, color: AppColors.red),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount =>
      controller.news.length + (controller.isAdding.value ? 1 : 0);

  @override
  int get selectedRowCount => 0;
}