import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:task_P2/core/data/models/evalution_model.dart';

class EvalutionViewController extends GetxController {
  static EvalutionViewController get instance=>Get.find();
  List<EvalutionModel> evaluations=[
    EvalutionModel(question1: "نعم", question2: "نعم", question3: 5),
    EvalutionModel(question1: "نعم", question2: "نعم", question3:4),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 4),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:3),
    EvalutionModel(question1: "نعم", question2: "نعم", question3: 3),
    EvalutionModel(question1: "نعم", question2: "نعم", question3: 2),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 3),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:2),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:3),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:4),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:4),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 2),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:1),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:1),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 3),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 2),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 3),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 5),
    EvalutionModel(question1: "لاء", question2: "لاء", question3:1),
    EvalutionModel(question1: "لاء", question2: "لاء", question3: 4),
    EvalutionModel(question1: "نعم", question2: "نعم", question3:2),

  ];
  var result=<String, int>{}.obs;
  var result2=<String, int>{}.obs;
  var yesRatioQ3 = 0.0.obs;
  var averageRatingQ3 = 0.0.obs;
RxList<String> items = [
  "الخدمة ممتازة",
  "التعامل راقٍ",
  "الاستجابة سريعة",
  "الدعم الفني سريع",
  "الأسعار مناسبة",
].obs;




  @override
  void onInit() {
    countYesNoInQuestion1();
    countYesNoInQuestion2();
    calculateYesRatioInQuestion2(); 
     calculateAverageRatingQ3();
    // TODO: implement onInit
    super.onInit();
  }
 void countYesNoInQuestion1() {
  int yes = 0;
  int no = 0;

  for (var eval in evaluations) {
    if (eval.question1 == 'نعم') {
      yes++;
    } else if (eval.question1 == 'لاء') {
      no++;
    }
  }
result.clear();
result.addAll({"نعم": yes, "لاء": no});

    
}
 void countYesNoInQuestion2() {
  int yes = 0;
  int no = 0;

  for (var eval in evaluations) {
    if (eval.question2 == 'نعم') {
      yes++;
    } else if (eval.question2 == 'لاء') {
      no++;
    }
  }
result2.clear();
result2.addAll({"نعم": yes, "لاء": no});

    
}
void calculateYesRatioInQuestion2() {
  int total = evaluations.length;
  int yesCount = evaluations.where((e) => e.question2.trim() == 'نعم').length;

  if (total == 0) {
    yesRatioQ3.value = 0.0;
  } else {
    yesRatioQ3.value = yesCount / total;
  }
}
void calculateAverageRatingQ3() {
  final validRatings = evaluations
      .map((e) => e.question3)
      .where((value) => value != null)
      .cast<int>()
      .toList();

  if (validRatings.isEmpty) {
    averageRatingQ3.value = 0.0;
    return;
  }

  final total = validRatings.reduce((a, b) => a + b);
  averageRatingQ3.value = total / validRatings.length;
}


}