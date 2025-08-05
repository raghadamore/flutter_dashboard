import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/shared_widgets/templates/login_template.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/forget_password/forget_password_controller.dart';
import 'package:task_P2/ui/views/verify_code_view/verify_code_controller.dart';

class VerifyCodeDesktopTablet extends StatefulWidget {
  const VerifyCodeDesktopTablet({super.key});

  @override
  State<VerifyCodeDesktopTablet> createState() => _VerifyCodeDesktopTabletState();
}

class _VerifyCodeDesktopTabletState extends State<VerifyCodeDesktopTablet> {
 VerifyCodeController controller=VerifyCodeController.instance;

  Widget _buildCodeField(int index) {
    return Container(
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Builder(
        builder: (context) => TextField(
          controller:controller. controllers[index],
          focusNode:controller. focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 1,
          buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
          style: const TextStyle(
            fontSize: 24,
            letterSpacing: 2,
          ),
          cursorColor:AppColors.primary ,
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
            focusedBorder:OutlineInputBorder(borderSide: BorderSide(color:AppColors.primary, )) ,
            hoverColor: AppColors.primary,
            
          ),
          onChanged: (value) =>controller. onChanged(value, index),
          textDirection: TextDirection.ltr, // ← مفتاح الحل داخل TextField مباشرة
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ForgetPsswordController forgetcontroller=ForgetPsswordController.instance;
    return TLoginTemplate(
      child: Column(
        children: [
          Directionality( // تأكد من أن هذه الواجهة بالكامل من اليسار لليمين
            textDirection: TextDirection.ltr,
            child:
               Center(
                child: Column(
                  
                  children: [
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         IconButton(
            onPressed: () => Get.offAllNamed(TRoutes.forgetPassword), icon: const Icon(Icons.arrow_back,color: AppColors.primary,)),
                        Text("إدخال رمز تحقق",style: TextStyle(color: AppColors.primary,fontSize: screenWidth(26)),),
                         Text("يتم إرسال الرمز إلى البريد الخاص بك",style: TextStyle(color: AppColors.primary,fontSize: screenWidth(30)),),
                      ],
                    ),
                   
                     SizedBox(height: TSize.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, _buildCodeField),
                    ),
                    const SizedBox(height: 150),
                    ElevatedButton(
                      
                      onPressed: () {
                        String code =controller. controllers.map((c) => c.text).join();
                        forgetcontroller.setVerificationCode(code);
                        forgetcontroller.confirmOtp();
                      },
                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor: AppColors.secondcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          
                        ),
                        fixedSize: const Size(200, 40),
                       // padding: const EdgeInsets.all(16),
                      ),
                      child: const Text(
                        'تأكيد',
                        style: TextStyle(fontSize: 22,color: AppColors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}
