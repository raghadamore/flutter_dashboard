import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:html' as html;

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:task_P2/core/data/models/data_model.dart';
import 'package:task_P2/core/data/models/order_model.dart';

import 'package:task_P2/ui/shared/colors.dart';
import 'package:task_P2/ui/shared/custom _widgets/dashboard_card.dart';
import 'package:task_P2/ui/shared/custom _widgets/pie_chart.dart';
import 'package:task_P2/ui/shared/custom _widgets/pie_chart_monthly.dart';
import 'package:task_P2/ui/shared/custom%20_widgets/line_chart_monthly.dart';

import 'package:task_P2/ui/shared/size.dart';
import 'package:task_P2/ui/shared/utlis.dart';
import 'package:task_P2/ui/views/argricultural_project_form/argricultural_project_form_controller.dart';
import 'package:task_P2/ui/views/reports_view/reports_view_controller.dart';
import 'package:task_P2/ui/views/business_project_form/business_project_form_controller.dart';
import '../../../shared/custom _widgets/custom_rounded_container.dart';

class MaterialProjectTablet extends StatelessWidget {
  const MaterialProjectTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=ArgriculturalProjectFormController.instance;
    return LayoutBuilder(
     builder: (BuildContext context, BoxConstraints constraints) { 
     return SingleChildScrollView(
       child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
          
           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Expanded(
                 child: TRoundedContainer(
                   margin: EdgeInsets.all(10),
                   width: screenWidth(0.6),
                  height: screenWidth(2.6),
                    child: Column(
                      children: [
                        Text("المعلومات الشخصية",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.normal,fontSize: screenWidth(28)),),
                        SizedBox(height: TSize.spaceBtwItems,),
                        Container(
                          
                          width: screenWidth(0.60),
                          height: screenWidth(5),
                          decoration: BoxDecoration(color: AppColors.white,border: Border.all(color: AppColors.black)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth:constraints.maxWidth ),
                              child:Obx((){
                              return DataTable2(
                                minWidth: 1000,
                                columnSpacing: 20,
                                headingRowColor: WidgetStatePropertyAll(AppColors.secondcolor),
                                columns:  [
                                  DataColumn(label: Text("الاسم الثلاثي")),
                                  DataColumn(label: Text("البريد الالكتروني")),
                                  DataColumn(label: Text("تاريخ الميلاد")),
                                  DataColumn(label: Text("الجنس")), // للحذف أو الحفظ
                                  DataColumn(label: Text("رقم الهاتف")), // للحذف أو الحفظ
                                  DataColumn(label: Text("العنوان السابق")), 
                                  DataColumn(label: Text("العنوان الحالي")), 
                                  
                                ],
                                rows: [
                                 
                                  ...controller.info.map((user) => DataRow(
                                    cells: [
                                      DataCell(Text(user.name)),
                                      DataCell(Text(user.email)),
                                      DataCell(Text(user.dateTime.toString())),
                                              
                                      DataCell(Text(user.gender)),
                                      DataCell(Text(user.phone)),
                                      DataCell(Text(user.lastAddress)),
                                      DataCell(Text(user.currentAddress)),
                                      
                                    ],
                                  )),
                                  
                                ],
                              );})
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
               ),
             ],
           ),
          
          
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TRoundedContainer(
                  margin: EdgeInsets.all(10),
                  width: screenWidth(0.6),
                  height: screenWidth(2.6),
                  child: Column(
                    children: [
                      Text("تفاصيل اجتماعية",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.normal,fontSize: screenWidth(28)),),
                      SizedBox(height: TSize.spaceBtwItems,),
                      Container(
                       
                        width: screenWidth(0.60),
                        height: screenWidth(5),
                        decoration: BoxDecoration(color: AppColors.white,border: Border.all(color: AppColors.black)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                            child: Obx((){
                              return DataTable2(
                                minWidth: 1000,
                                  columnSpacing: 20,
                                  headingRowColor: WidgetStatePropertyAll(AppColors.secondcolor),
                                   columns:  [
                                    DataColumn(label: Text("التحصيل العلمي")),
                                    DataColumn(label: Text("عدد أفراد الأسرة",)),
                                    
                                    DataColumn(label: Text("الخلفية الشخصية")), // للحذف أو الحفظ
                                    DataColumn(label: Text("العمل الحالي")), // للحذف أو الحفظ
                                    DataColumn(label: Text("الحالة الاجتماعية")), 
                                    DataColumn(label: Text("نقاط ضعف /إعاقة")), 
                                    
                                  ],
                                  rows: [
                                   
                                    ...controller.infoForstauts.map((user) => DataRow(
                                      cells: [
                                              DataCell(Text(user.name,)),
                                              DataCell(Text(user.email)),
                                              
                                  
                                              DataCell(Text(user.gender)),
                                              DataCell(Text(user.phone)),
                                              DataCell(Text(user.lastAddress)),
                                              DataCell(Text(user.currentAddress)),
                                              
                                      ],
                                    )),
                                    
                                  ],
                              );}
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
         
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(
                child: TRoundedContainer(
                  margin: EdgeInsets.all(10),
                  width: screenWidth(0.6),
                  height: screenWidth(1.7),
                  child:Column(
                    children: [
                       Text("تفاصيل اقتصادية",style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.normal,fontSize: screenWidth(28)),),
                      SizedBox(height: TSize.spaceBtwItems,),
                     
                       Row(
                        children: [
                          Container(width: 8,height: 8,
                          margin: EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(color:AppColors.primary,shape: BoxShape.circle),
                
                          ),
                          SizedBox(width: 8,),
                          Text("الملاحظات:",style: TextStyle(color: AppColors.black,fontSize: screenWidth(35)),)
                        ],
                      ),
                    ],
                  ) ,
                ),
              ),
            ],
          ),
          SizedBox(height: TSize.spaceBtwSections,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: screenWidth(6),
                height: screenWidth(14),
                child: ElevatedButton(onPressed: (){}, 
                  child:Text("قبول",style: TextStyle(color: AppColors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondcolor),
                  
                  ),
              ),
              SizedBox(width: TSize.spaceBtwItems,),
              SizedBox(
                width: screenWidth(6),
                height: screenWidth(14),
                child: ElevatedButton(onPressed: (){}, 
                  child:Text("رفض",style: TextStyle(color: AppColors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondcolor),
                  
                  ),
              ),
            ],
          ),
          SizedBox(height: TSize.spaceBtwSections,)
          ],
        ),
     );
      },
   );
  }
}


  