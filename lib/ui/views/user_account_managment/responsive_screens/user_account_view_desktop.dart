
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:task_P2/core/data/models/userAcount_model.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/user_account_managment/user_account_managment_view_controller.dart';

class UserAccountViewDesktop extends StatelessWidget {
  const UserAccountViewDesktop({super.key});

  @override
  Widget build(BuildContext contextr) {
     final controller=UserAccountManagmentViewController.instance;
    return SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSize.spaceBtwSections,),
          ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                ),
                onPressed:(){
                 controller.addingNewUser.value=true;
                  },  
                child: Container(
                  width: screenWidth(5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.primary,
                      ),
                      Text(
                        "إضافة حساب",
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: screenWidth(35)),
                      ),

                    ],
                  ),
                )),
                 SizedBox(height: TSize.spaceBtwItems,),
                Obx(() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.all(10),
        width: screenWidth(0.8),
        height: screenWidth(3),
        decoration: BoxDecoration(color: AppColors.white,border: Border.all(color: AppColors.black)),
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 40,
            headingRowColor: WidgetStatePropertyAll(AppColors.secondcolor),
            columns: const [
              DataColumn(label: Text("كلمة المرور")),
              DataColumn(label: Text("البريد الالكتروني")),
              DataColumn(label: Text("اسم المستخدم")),
              DataColumn(label: Text("")), // للحذف أو الحفظ
            ],
            rows: [
              if (controller.addingNewUser.value)
                DataRow(
                  cells: [
                    DataCell(TextField(controller:controller. passCtrl)),
                    DataCell(TextField(controller:controller. emailCtrl)),
                    DataCell(TextField(controller:controller. nameCtrl)),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.blue),
                        onPressed: () {
                          controller.addUser(UserAccountModel(
                            name:controller. nameCtrl.text,
                            email:controller. emailCtrl.text,
                            password:controller. passCtrl.text,
                          ));
                         controller. nameCtrl.clear();
                         controller. emailCtrl.clear();
                         controller. passCtrl.clear();
                          controller.addingNewUser.value = false;
                        },
                      ),
                    ),
                  ],
                ),
              ...controller.users.map((user) => DataRow(
                cells: [
                  DataCell(Text(user.password)),
                  DataCell(Text(user.email)),
                  DataCell(Text(user.name)),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.users.remove(user);
                      },
                    ),
                  ),
                ],
              )),
              
            ],
          ),
        ),
      ),
    ],
  );
})


        ],
      ),
    );
  }
}