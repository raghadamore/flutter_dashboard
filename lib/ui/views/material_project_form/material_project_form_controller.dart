import 'package:get/get.dart';
import 'package:task_P2/core/data/models/business_project_model.dart';

class MaterialProjectFormController extends GetxController {
  static MaterialProjectFormController get instance=>Get.find();
  RxList<BusinessProjectModel> info=<BusinessProjectModel>[
  BusinessProjectModel(name: "ahmad", email: "ahmadamore@gmil.com", dateTime: DateTime(2025,6,25), gender: "ذكر", lastAddress: "hhhg", currentAddress: "hama", phone: '123456789')

  ].obs;
  RxList<BusinessProjectModel> infoForstauts=<BusinessProjectModel>[
  BusinessProjectModel(name: "ahmad", email: "ahmadamore@gmil.com", dateTime: DateTime(2025,6,25), gender: "ذكر", lastAddress: "hhhg", currentAddress: "hama", phone: '123456789')

  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}