import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/custom_rounded_container.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/table_news/data_table_news.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/table_news/table_source.dart';

import 'package:task_P2/ui/shared/size.dart';

import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/news_view/news_view_controlller.dart';
import 'package:task_P2/ui/views/news_view/responsive_screeens/news_tablet.dart';

class NewsViewDesktop extends StatelessWidget {
  const NewsViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = NewsViewControlller.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                TRoundedContainer(
                  height: screenWidth(2.3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pick Image
                      controller.imageBase64!=null?
                      Container(
                          width: screenWidth(3),
                          height: screenWidth(1.5),
                          child:Image(image:MemoryImage(controller.imageBase64!) )
                           
                      ):
                      Container(
                          width: screenWidth(3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondcolor,),
                              onPressed: controller.pickImage,
                              
                              child: const Text('اختيار صورة',style: TextStyle(color: AppColors.black)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth(10),),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screenWidth(0.9),
                          height: screenHeight(1.2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          
                            children: [
                          
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondcolor,),
                            onPressed: () => controller.pickDate(context),
                            child: Text(
                              controller.selectedDate == null
                                  ? 'اختيار التاريخ'
                                  : controller.selectedDate!.toLocal().toString().split(' ')[0]
                                  ,style: TextStyle(color: AppColors.black)
                            ),
                          ),
                                           
                          // Description
                          SizedBox(height:  TSize.spaceBtwSections),
                         Expanded (
                            child: TextFormField(
                              
                              maxLines: null,
                              controller: controller.descController,
                              decoration:  InputDecoration(labelText: 'نص النشاط',focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.secondcolor)) ,hintStyle: TextStyle(color: AppColors.secondcolor),),
                            ),
                          ),
                           SizedBox(height: screenWidth(7)),
                          // Add Button
                          Padding(
                            padding:  EdgeInsets.only(right:screenWidth(1.01)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondcolor,),
                              onPressed: controller.addActivity,
                              child: const Text('إضافة',style: TextStyle(color: AppColors.black),),
                            ),
                          ),
                            ],
                          ),
                        ),
                      ),
                      // Pick Date
                      
                    ],
                  ),
                ),
              SizedBox(height: TSize.spaceBtwSections),
             
              TRoundedContainer(
                height: screenWidth(2),
                child: NewsTable(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
