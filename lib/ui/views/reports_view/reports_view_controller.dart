import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/models/data_model.dart';
import 'package:task_P2/core/data/models/order_model.dart';
import 'package:task_P2/core/data/repository/agricultural_repository.dart';
import 'package:task_P2/core/data/repository/commerical_repository.dart';
import 'package:task_P2/core/data/repository/material_repository.dart';
import 'package:task_P2/core/data/repository/medical_repository.dart';
import 'package:task_P2/core/enums/order_status_enum.dart';
import 'package:task_P2/core/enums/order_type_enum.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class ReportsViewController extends GetxController{
  
  static ReportsViewController get instance=>Get.find();
  
  final RxList<double> weeklySales=<double>[].obs;
  static final List<OrderModel> orders=[
    OrderModel(id:123,status:OrderStatus.ACCEPTED
    ,orderDate:DateTime(2024,6,20), type:  "مشاريع صغيرة"),
    OrderModel(id: 12,status:OrderStatus.PENDING,orderDate:DateTime(2025,6,20),type:"مساعدات عينية"),
    OrderModel(id: 1234,status:OrderStatus.REJECTED,orderDate:DateTime(2025,6,20),type: "مساعدات عينية"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,6,20),type: "مساعدات طبية"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,6,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,7,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,8,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,8,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,8,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,8,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,8,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,8,20),type: "مشاريع صغيرة"),
    OrderModel(id: 12444,status:OrderStatus.ACCEPTED,orderDate:DateTime(2025,8,20),type: "مشاريع صغيرة"),
  ];
  
 var percentages = <String, double>{}.obs;
RxInt numMedicalPeriodAllApprovied = 0.obs;
  RxInt numMmaterialPeriodAllApprovied = 0.obs;
  RxInt numAgriculturePeriodAllApprovied = 0.obs;
  RxInt numCommericalPeriodAllApprovied = 0.obs;

RxInt numMedicalPeriodAllRejected = 0.obs;
  RxInt numMmaterialPeriodAllRejected = 0.obs;
  RxInt numAgriculturePeriodAllRejected = 0.obs;
  RxInt numCommericalPeriodAllRejected = 0.obs;

RxInt numAllMedicalPeriodAll = 0.obs;
  RxInt numAllMmaterialPeriodAll = 0.obs;
  RxInt numAllAgriculturePeriodAll = 0.obs;
  RxInt numAllCommericalPeriodAll = 0.obs;

 RxInt allMedicalNum = 0.obs;
  RxInt allMaterialNum = 0.obs;
  RxInt allCommericalNum = 0.obs;
  RxInt allAgriculturNum = 0.obs;
  RxInt allprojectsNum = 0.obs;


 RxInt allProjectRejectedNum = 0.obs;
 RxInt allProjectApprovidNum = 0.obs;
 RxInt allProjectNum = 0.obs;
  
  
  @override
  void onInit() {
    super.onInit();
    calculateCurrentMonthPercentages();
    calculateApproveProjectPerAll();
     calculateApproveProjectPerAll().then((_) {
    print("Total approved: ${allProjectApprovidNum.value}");
    print("Total rejected: ${allProjectRejectedNum.value}");
    print("Total: ${allProjectNum.value}");
  });
  }

  void calculateCurrentMonthPercentages() {
    final monthlyCounts = groupOrdersByMonthAndType(orders);

    DateTime now = DateTime.now();
    String currentMonthKey = "${now.year}-${now.month.toString().padLeft(2, '0')}";

    if (monthlyCounts.containsKey(currentMonthKey)) {
      percentages.value = calculatePercentagesForMonth(monthlyCounts[currentMonthKey]!);
    } else {
      percentages.clear();
    }
  }

  Map<String, Map<String, int>> groupOrdersByMonthAndType(List<OrderModel> orders) {
    Map<String, Map<String, int>> result = {};

    for (var order in orders) {
      String monthKey = "${order.orderDate!.year}-${order.orderDate!.month.toString().padLeft(2, '0')}";

      if (!result.containsKey(monthKey)) {
        result[monthKey] = {};
      }

      result[monthKey]![order.type!] = (result[monthKey]![order.type] ?? 0) + 1;
    }

    return result;
  }

  Map<String, double> calculatePercentagesForMonth(Map<String, int> typeCounts) {
    int total = typeCounts.values.reduce((a, b) => a + b);
    Map<String, double> result = {};

    typeCounts.forEach((type, count) {
      result[type] = (count / total) * 100;
    });

    return result;
  }

  List<int> getAcceptedOrdersPerMonth(List<OrderModel> orders) {
  List<int> monthlyCounts = List.filled(12, 0);

  for (var order in orders) {
    if (order.status ==OrderStatus.ACCEPTED) {
      int month = order.orderDate!.month;
      monthlyCounts[month - 1]++;
    }
  }

  return monthlyCounts;
}

  Future<void> getMedicalProjectPerPeriod(String period) async {
   await MedicalRepository().getMedicalProjectPeriod(period: period).then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
          numMedicalPeriodAllApprovied.value = r.approved ?? 0;
          numMedicalPeriodAllRejected.value = r.rejected ?? 0;
          numAllMedicalPeriodAll.value = r.total ?? 0;
        },
      );
    });
}


 
  Future<void> getMaterialProjectPerPeriod(String period) async {
   await MaterialRepository().getMaterialProjectPeriod(period: period).then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
          numMmaterialPeriodAllApprovied.value=r.approved??0;
         numMmaterialPeriodAllRejected.value=r.rejected??0;
         numAllMmaterialPeriodAll.value=r.total??0;
        },
      );
    });
}



   Future<void> getAgricultureProjectPerPeriod(String period) async {
   await AgriculturalRepository().getAgriculltureProjectPeriod(period: period).then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
         numAgriculturePeriodAllApprovied.value=r.approved??0;
          numAgriculturePeriodAllRejected.value=r.rejected??0;
          numAllAgriculturePeriodAll.value=r.total??0;
        },
      );
    });
}

 
   Future<void> getCommericalProjectPerPeriod(String period) async {
   await CommericalRepository().getCommericalProjectPeriod(period: period).then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
        numCommericalPeriodAllApprovied.value=r.approved??0;
          numCommericalPeriodAllRejected.value=r.rejected??0;
          numAllCommericalPeriodAll.value=r.total??0;
        },
      );
    });
} 
 Future<void> calculateApproveProjectPerAll() async {
  await Future.wait<void>([
    getAgricultureProjectPerPeriod("all"),
    getMedicalProjectPerPeriod("all"),
    getMaterialProjectPerPeriod("all"),
    getCommericalProjectPerPeriod("all"),
  ]);

  allProjectApprovidNum.value = numMedicalPeriodAllApprovied.value +
      numMmaterialPeriodAllApprovied.value +
      numAgriculturePeriodAllApprovied.value +
      numCommericalPeriodAllApprovied.value;

  allProjectRejectedNum.value = numMedicalPeriodAllRejected.value +
      numMmaterialPeriodAllRejected.value +
      numAgriculturePeriodAllRejected.value +
      numCommericalPeriodAllRejected.value;

  allProjectNum.value = numAllAgriculturePeriodAll.value +
      numAllCommericalPeriodAll.value +
      numAllMedicalPeriodAll.value +
      numAllMmaterialPeriodAll.value;
}

  
}




