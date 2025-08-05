import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:task_P2/core/data/models/beneficiary_model.dart';
import 'package:task_P2/core/data/models/common_response.dart';
import 'package:task_P2/core/data/models/project_model.dart';
import 'package:task_P2/core/data/models/status_and_type_project_model.dart';
import 'package:task_P2/core/data/network/network_config.dart';
import 'package:task_P2/core/enums/request_type.dart';
import 'package:task_P2/core/utils/network_util.dart';

class BeneficiaryRepository {
  Future<Either<String, List<BeneficiaryModel>>> getAllBeneficiary() async {
    try {
      print("rrr");
      final value = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: 'dashboard/users/beneficiary/',
        headers:
            NetworkConfig.getHeaders(type: RequestType.GET, needAuth: true),
      );
print("benec");
print(value);
      final statusCode = value['statusCode'];
      final responseData = value['response'];
      if (statusCode == null) {
        return Left('خطأ في استلام البيانات، رمز الحالة غير موجود');
      }
      if (statusCode == null || statusCode.toString()[0] != '2') {
        return Left('خطأ في استلام البيانات، رمز الحالة: $statusCode');
      }

      if (responseData == null) {
        return Left('حدث خطأ في استلام البيانات من السيرفر');
      }

      // هنا responseData هي List<dynamic>
      List<BeneficiaryModel> projects =
          (responseData as List).map((e) => BeneficiaryModel.fromJson(e)).toList();

      return Right(projects);
    } catch (e) {
      return Left('خطأ في الاتصال: ${e.toString()}');
    }
  }


}
