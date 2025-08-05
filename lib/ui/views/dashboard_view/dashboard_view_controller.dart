import 'dart:convert';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_P2/core/data/models/data_model.dart';
import 'package:task_P2/core/data/models/medical_period_model.dart';
import 'package:task_P2/core/data/models/order_model.dart';
import 'package:task_P2/core/data/models/project_model.dart';
import 'package:task_P2/core/data/models/status_and_type_project_model.dart';
import 'package:task_P2/core/data/repository/agricultural_repository.dart';
import 'package:task_P2/core/data/repository/commerical_repository.dart';
import 'package:task_P2/core/data/repository/material_repository.dart';
import 'package:task_P2/core/data/repository/medical_repository.dart';
import 'package:task_P2/core/data/repository/project_repository.dart';
import 'package:task_P2/core/enums/order_status_enum.dart';
import 'package:task_P2/core/enums/order_type_enum.dart';
import 'package:task_P2/core/translation/app_translation.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/argricultural_project_form/responsive_screens/argricultural_project_desktop.dart';

class DashboardViewController extends GetxController {
  static DashboardViewController get instance => Get.find();
  RxBool isLoading=true.obs;
  final RxList<double> weeklySales = <double>[].obs;
  RxList<ProjectModel> lastFiveOrder = <ProjectModel>[].obs;
  RxList<ProjectModel> orders = <ProjectModel>[].obs;
  RxList<StatusAndTypeProjectModel> projectsTypeStatusForMedical = <StatusAndTypeProjectModel>[].obs;
  RxList<StatusAndTypeProjectModel> projectsTypeStatusForMaterial = <StatusAndTypeProjectModel>[].obs;
  RxList<StatusAndTypeProjectModel> projectsTypeStatusForAgricalture = <StatusAndTypeProjectModel>[].obs;
  RxList<StatusAndTypeProjectModel> projectsTypeStatusForCommerical = <StatusAndTypeProjectModel>[].obs;
  final RxMap<String, int> OrderStatusData = <String, int>{}.obs;
  RxInt medicalPeriodAll = 0.obs;
  RxInt materialPeriodAll = 0.obs;
  RxInt AgriculturePeriodAll = 0.obs;
  RxInt commericalPeriodAll = 0.obs;

  RxInt commericalApprovedNumPerMonth = 0.obs;
  RxInt agriculturApprovedNumPerMonth = 0.obs;
  RxInt medicalApprovedNumPerMonth = 0.obs;
  RxInt materialApprovedNumPerMonth = 0.obs;

  RxInt commericalApprovedNumPerDay = 0.obs;
  RxInt agriculturApprovedNumPerDay = 0.obs;
  RxInt medicalApprovedNumPerDay = 0.obs;
  RxInt materialApprovedNumPerDay = 0.obs;

  RxInt commericalRejectedNumPerDay = 0.obs;
  RxInt agricultureRjectedNumPerDay = 0.obs;
  RxInt medicalRejectedNumPerDay = 0.obs;
  RxInt materialRejectedNumPerDay = 0.obs;

  RxInt ApprovedProjectNumPerDay = 0.obs;
  RxInt rejectedProjectNumPerDay = 0.obs;
  RxInt pendingProjectNumPerDay = 0.obs;

  RxInt allMedicalNumPerDay = 0.obs;
  RxInt allMaterialNumPerDay = 0.obs;
  RxInt allCommericalNumPerDay = 0.obs;
  RxInt allAgriculturNumPerDay = 0.obs;
  RxInt allprojectsNumPerDay = 0.obs;


  static final List<ProjectModel> order = [];
  var percentages = <String, double>{}.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    loadDashboardData();
  
    getMedicalProjectPerPeriod("all");
    getMedicalProjectPerPeriod("month");
    getMaterialProjectPerPeriod("all");
    getMaterialProjectPerPeriod("month");
    getAgricultureProjectPerPeriod("all");
    getAgricultureProjectPerPeriod("month");
    getCommericalProjectPerPeriod("all");
    getCommericalProjectPerPeriod("month");
    calculateGeneralTypePercentages();
    calculateApproveProjectPerDay();
    calculatePendingProjectNum();
    print(orders.length);
  }
void loadDashboardData()async{
  isLoading.value=true;
  await getAllProjects();
  isLoading.value=false;
}


 Future<void> getAllProjects() async {
  final result = await ProjectRepository().getAllProjects();
  result.fold(
    (l) => BotToast.showText(text: l),
    (r) {
      orders.assignAll(r);
      print('Orders after fetch: ${orders.length}');
      _calculeteOrderStatusData();
      calculateGeneralTypePercentages();
      calculateLastFiveOrder();
      _calculeteWeeklySales();
    },
  );
}
 Future<void> getAllProjectsByStatusAndType(String type,String status) async {
  final result = await ProjectRepository().getAllProjectsByStatusAndType(type: type,status: status);
  result.fold(
    (l) => BotToast.showText(text: l),
    (r) {
      if (type=="commerical"&&status=="pending") {
         projectsTypeStatusForCommerical.assignAll(r);
      }else if(type=="agricultural"&&status=="pending"){
         projectsTypeStatusForAgricalture.assignAll(r);

      }else if(type=="medical"&&status=="pending"){
         projectsTypeStatusForMedical.assignAll(r);

      }else{
        projectsTypeStatusForMedical.assignAll(r);
      }
      
      
      
    },
  );
}
Future<void> calculatePendingProjectNum() async {
  await Future.wait([
    getAllProjectsByStatusAndType("commerical", "pending"),
    getAllProjectsByStatusAndType("agricultural", "pending"),
    getAllProjectsByStatusAndType("medical", "pending"),
    getAllProjectsByStatusAndType("material", "pending"),
  ]);

  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  projectsTypeStatusForMedical.assignAll(
    projectsTypeStatusForMedical.where((order) => order.requestDate == today).toList(),
  );
  projectsTypeStatusForMaterial.assignAll(
    projectsTypeStatusForMaterial.where((order) => order.requestDate == today).toList(),
  );
  projectsTypeStatusForCommerical.assignAll(
    projectsTypeStatusForCommerical.where((order) => order.requestDate == today).toList(),
  );
  projectsTypeStatusForAgricalture.assignAll(
    projectsTypeStatusForAgricalture.where((order) => order.requestDate == today).toList(),
  );

  pendingProjectNumPerDay.value =
      projectsTypeStatusForMedical.length +
      projectsTypeStatusForMaterial.length +
      projectsTypeStatusForCommerical.length +
      projectsTypeStatusForAgricalture.length;
}




  void getMedicalProjectPerPeriod(String period) {
    MedicalRepository().getMedicalProjectPeriod(period: period).then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
          if (period == "month") {
            medicalApprovedNumPerMonth.value = r.approved ?? 0;
          } 
        else if (period == "day") {
            medicalApprovedNumPerDay.value = r.approved ?? 0;
            medicalRejectedNumPerDay.value = r.rejected ?? 0;
            allMedicalNumPerDay.value = r.total ?? 0;

          } else {
            medicalPeriodAll.value = r.total ?? 0;
          }
        },
      );
    });
  }

  void getMaterialProjectPerPeriod(String period) {
    MaterialRepository().getMaterialProjectPeriod(period: period).then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
          if (period == "month") {
            materialApprovedNumPerMonth.value = r.approved ?? 0;
          } 
          else if (period == "day") {
            materialApprovedNumPerDay.value = r.approved ?? 0;
            materialRejectedNumPerDay.value = r.rejected ?? 0;
            allMaterialNumPerDay.value = r.total ?? 0;
          } else {
            materialPeriodAll.value = r.total ?? 0;
          }
        },
      );
    });
  }

  void getAgricultureProjectPerPeriod(String period) {
    AgriculturalRepository()
        .getAgriculltureProjectPeriod(period: period)
        .then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
          if (period == "month") {
            agriculturApprovedNumPerMonth.value = r.approved ?? 0;
          } 
         else if (period == "day") {
            agriculturApprovedNumPerDay.value = r.approved ?? 0;
            agricultureRjectedNumPerDay.value = r.rejected ?? 0;
            allAgriculturNumPerDay.value = r.total ?? 0;
          } else {
            AgriculturePeriodAll.value = r.total ?? 0;
          }
        },
      );
    });
  }

  void getCommericalProjectPerPeriod(String period) {
    CommericalRepository()
        .getCommericalProjectPeriod(period: period)
        .then((value) {
      value.fold(
        (l) {
          BotToast.showText(text: l);
          print("Error: $l");
        },
        (r) {
          if (period == "month") {
            commericalApprovedNumPerMonth.value = r.approved ?? 0;
           
          }else if(period=="day") {
            commericalApprovedNumPerDay.value=r.approved?? 0;
            commericalRejectedNumPerDay.value=r.rejected?? 0;
            allCommericalNumPerDay.value = r.total ?? 0;
            print("total"+allCommericalNumPerDay.toString());
          }
           else {
            commericalPeriodAll.value = r.total ?? 0;
          }
        },
      );
    });
  }

  void refreshdata() {
    orders.clear();
    getAllProjects();
  }

  void _calculeteOrderStatusData() {
    OrderStatusData.clear();
    for (var order in orders) {
      final status = order.statusDisplay;
      OrderStatusData[status!] = (OrderStatusData[status] ?? 0) + 1;
    }
  }

  Map<OrderTypeEnum, double> calculatePercentage(
      Map<OrderTypeEnum, int> typeCount) {
    int total = typeCount.values.reduce((a, b) => a + b);
    Map<OrderTypeEnum, double> percentage = {};
    typeCount.forEach((key, value) {
      percentage[key] = (value / total) * 100;
    });

    return percentage;
  }

  void _calculeteWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0);
    DateFormat format = DateFormat("yyyy-MM-dd");
    for (var order in orders) {
      final DateTime orderDate = format.parse(order.requestDate!);
      final DateTime orderWeekStart = getStartOfWeek(orderDate);

      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (orderDate.weekday - 1) % 7;
        index = index < 0 ? index + 7 : index;

        // افترضت أن كل طلب قيمته 1
        weeklySales[index] = weeklySales[index] + 1;

        print(
            "orderDate: $orderDate, currentWeekDay: $orderWeekStart, index: $index");
      }
    }

    print("weekly sales: $weeklySales");
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.ACCEPTED:
        return "مقبول";
      case OrderStatus.PENDING:
        return "قيد الانتظار";
      case OrderStatus.REJECTED:
        return "مرفوض";
      default:
        return "unknown";
    }
  }
void calculateApproveProjectPerDay(){
  getAgricultureProjectPerPeriod("day");
  getMedicalProjectPerPeriod("day");
  getMaterialProjectPerPeriod("day");
  getCommericalProjectPerPeriod("day");
 ApprovedProjectNumPerDay.value=medicalApprovedNumPerDay.value+materialApprovedNumPerDay.value+commericalApprovedNumPerDay.value+agriculturApprovedNumPerDay.value;
 rejectedProjectNumPerDay.value=medicalRejectedNumPerDay.value+materialRejectedNumPerDay.value+commericalRejectedNumPerDay.value+agricultureRjectedNumPerDay.value;
allprojectsNumPerDay.value=allMedicalNumPerDay.value+allMaterialNumPerDay.value+allCommericalNumPerDay.value+allAgriculturNumPerDay.value;
}
  void calculateGeneralTypePercentages() {
    // فقط الطلبات المقبولة
    final acceptedOrders = medicalApprovedNumPerMonth.value +
        materialApprovedNumPerMonth.value +
        commericalApprovedNumPerMonth.value +
        agriculturApprovedNumPerMonth.value;

    if (acceptedOrders == 0) {
      percentages.clear();
      return;
    }

    // عد الأنواع
    final Map<String, int> typeCounts = {
      "مشاريع طبية": medicalApprovedNumPerMonth.value,
      "مساعدات عينية": materialApprovedNumPerMonth.value,
      "مشاريع زراعية": agriculturApprovedNumPerMonth.value,
      "مشاريع تجارية": commericalApprovedNumPerMonth.value
    };

    // احسب النسب
    final total = acceptedOrders;
    final Map<String, double> result = {};
    typeCounts.forEach((type, count) {
      result[type] = (count / total) * 100;
    });

    percentages.value = result;
  }

  void calculateLastFiveOrder() {
    List<ProjectModel> sortedOrders = [...orders];
    sortedOrders.sort((a, b) => b.requestDate!.compareTo(a.requestDate!));
    print("Sorted orders by date:");
    for (var order in sortedOrders) {
      print(order.requestDate);
    }
    lastFiveOrder.assignAll(sortedOrders.take(5).toList());
    print("lastFiveOrder length: ${lastFiveOrder.length}");
  }
}
