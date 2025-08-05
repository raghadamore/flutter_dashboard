import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/models/business_project_model.dart';
import 'package:task_P2/core/data/models/medical_project_detail_model.dart';
import 'package:task_P2/core/data/models/patch_project_model.dart';
import 'package:task_P2/core/data/repository/material_repository.dart';
import 'package:task_P2/core/data/repository/medical_repository.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/data_table/table_controller.dart';
import 'package:task_P2/ui/views/services_view/services_view_controller.dart';

class MedicalProjectFormController extends GetxController {
    ServicesViewController controller=ServicesViewController.instance;
  TableController controller1=TableController.instance;
  static MedicalProjectFormController get instance=>Get.find();
  
  Rxn<MedicalProjectDetailModel> detailsProject= Rxn<MedicalProjectDetailModel>();
  Rxn<PatchProjectModel> patchProjectValue= Rxn<PatchProjectModel>();
   RxBool sccess=false.obs;
  RxList<BusinessProjectModel> info=<BusinessProjectModel>[
  BusinessProjectModel(name: "ahmad", email: "ahmadamore@gmil.com", dateTime: DateTime(2025,6,25), gender: "ذكر", lastAddress: "hhhg", currentAddress: "hama", phone: '123456789')

  ].obs;
  RxList<BusinessProjectModel> infoForstauts=<BusinessProjectModel>[
  BusinessProjectModel(name: "ahmad", email: "ahmadamore@gmil.com", dateTime: DateTime(2025,6,25), gender: "ذكر", lastAddress: "hhhg", currentAddress: "hama", phone: '123456789')

  ].obs;
  final int index=  Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    int index= Get.arguments;
getData(index);
  }
   void getData(int index) {
    MedicalRepository().getMedicalProjectDetial(index: index,).then((value) {
      value.fold(
        (l) => BotToast.showText(text: l),
        (r) {
          detailsProject.value=r;
          
        },
      );
    });
  }
   void patchCommericalProject(int index,String status,String delivary_date) {
    MedicalRepository().patchMedicalProject(index: index,status: status,delivary_date: delivary_date).then((value) {
      value.fold(
        (l) { BotToast.showText(text: l);
        sccess.value=false;},
        (r) {
          patchProjectValue.value=r;
          sccess.value=true;
           BotToast.showText(text: "تم التعديل");
           
            controller1.markForRefresh(); // إشعار بالتحديث
                        Get.back();
        },
      );
    });
  }
}