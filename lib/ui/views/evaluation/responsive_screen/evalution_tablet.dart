import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/pie_chart_evalution.dart';
import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/evaluation/evalution_view_controller.dart';

class EvalutionViewTablet extends StatelessWidget {
  const EvalutionViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
   final controller =EvalutionViewController .instance;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSize.spaceBtwSections,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TRoundedContainer(
                  width: screenWidth(3),
                  height:screenWidth(1.9),
                  child: Column(
                    children: [
                      Text("هل تلقيت خدمات الجمعية بشكل مرضي؟",style: TextStyle(color: AppColors.primary),),
                       SizedBox(height: 3,),
                      EvalutionPieChart(result: controller.result,getColor: getColorForEvalution,),
                    ],
                  )),
              ),
                SizedBox(width: TSize.spaceBtwItems,),
              Expanded(
                child: TRoundedContainer(
                  width: screenWidth(3),
                  height:screenWidth(1.9),
                  child: Column(
                    children: [
                      Text("هل تنوي الاستفادة من خدمات الجمعية مرة اخرى في المستقبل؟",style: TextStyle(color: AppColors.primary),),
                       SizedBox(height: 2,),
                      EvalutionPieChart(result: controller.result2,getColor: getColorForEvalution,),

                    ],
                  )),
              ),
                SizedBox(width: TSize.spaceBtwItems,),
                Expanded(
                  child: TRoundedContainer(
                  width: screenWidth(1.6),
                  height:screenWidth(4),
                  child: Obx(() {
                    double value = controller.averageRatingQ3.value;
                    
                    double ratio = (value - 1) / 4;
                  
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("متوسط التقييمات", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary)),
                        const SizedBox(height: TSize.spaceBtwSections),
                        Row(
                          children: [
                            const Text("1"),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                  value: ratio.clamp(0.0, 1.0),
                  minHeight: 10,
                  backgroundColor: Colors.purple[100],
                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text("5"),
                          ],
                        ),
                      ],
                    );
                  }),
                  
                  ),
                )
            ],
          ),
          SizedBox(height: TSize.spaceBtwSections,),
          TRoundedContainer(
  height: screenWidth(4),
  width: screenWidth(0.8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "عرض الاقتراحات والملاحظات:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),

      // ⬇️ اجعل القائمة قابلة للتمرير ومستقلة
      Expanded(
        child: Obx(() => ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(Icons.circle, size: 8, color: Colors.deepPurple),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      controller.items[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      ),
    ],
  ),
),

          SizedBox(height: TSize.spaceBtwSections,)

        ],
      ),
    );
  }
  
}