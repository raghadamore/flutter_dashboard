import 'package:dartz/dartz.dart';
import 'package:task_P2/core/data/models/common_response.dart';
import 'package:task_P2/core/data/models/detail_project_model.dart';
import 'package:task_P2/core/data/models/medical_period_model.dart';
import 'package:task_P2/core/data/models/patch_project_model.dart';
import 'package:task_P2/core/data/models/project_model.dart';
import 'package:task_P2/core/data/network/network_config.dart';
import 'package:task_P2/core/enums/request_type.dart';
import 'package:task_P2/core/utils/network_util.dart';

class CommericalRepository {
  Future<Either<String, MedicalPeriodModel>> getCommericalProjectPeriod({
  required String period,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.GET,
      route: 'dashboard/stats/projects/commercial/',
      params: {"period": period},
      headers: NetworkConfig.getHeaders(type: RequestType.GET, needAuth: true),
    );


    final statusCode = value['statusCode'];
    final responseData = value['response'];

    if (statusCode == null) {
      return Left('خطأ في استلام البيانات، رمز الحالة غير موجود');
    }

    if (statusCode.toString()[0] != '2') {
      return Left('خطأ في استلام البيانات، رمز الحالة: $statusCode');
    }

    if (responseData == null) {
      return Left('حدث خطأ في استلام البيانات من السيرفر');
    }

    // responseData هو Map<String, dynamic> حسب الرد الأخير
    MedicalPeriodModel projects = MedicalPeriodModel.fromJson(responseData);

    return Right(projects);
  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}

Future<Either<String, List<ProjectModel>>> getAllCommericalProject({required String status}) async {
    try {
      final value = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: 'dashboard/projects/',
        params:{"status":status,"project_type":"commercial"},
        headers:
            NetworkConfig.getHeaders(type: RequestType.GET, needAuth: true),
      );

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

      
      List<ProjectModel> projects =
          (responseData as List).map((e) => ProjectModel.fromJson(e)).toList();

      return Right(projects);
    } catch (e) {
      return Left('خطأ في الاتصال: ${e.toString()}');
    }
  }
Future<Either<String, DetailProjectModel>> getDetailProject({
  required int index,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.GET,
      route: 'dashboard/projects/${index}',
     
      headers: NetworkConfig.getHeaders(type: RequestType.GET, needAuth: true),
    );
print('Full response from sendRequest: $value');
print('statusCode: ${value['statusCode']}');
print('response: ${value['response']}');
print('response runtimeType: ${value['response']?.runtimeType}');

    final statusCode = value['statusCode'];
    final responseData = value['response'];

    if (statusCode == null) {
      return Left('خطأ في استلام البيانات، رمز الحالة غير موجود');
    }

    if (statusCode.toString()[0] != '2') {
      return Left('خطأ في استلام البيانات، رمز الحالة: $statusCode');
    }

    if (responseData == null) {
      return Left('حدث خطأ في استلام البيانات من السيرفر');
    }

    
    DetailProjectModel projects = DetailProjectModel.fromJson(responseData);

    return Right(projects);
  } catch (e) {
    
  print('خطأ في الاتصال: ${e.toString()}');
  
  return Left('خطأ في الاتصال: ${e.toString()}');


    
  }
}

  Future<Either<String, PatchProjectModel>> patchCommericalProject({
  required int index,
  required String status,
  required String delivary_date,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.PATCH,
      route: 'dashboard/projects/${index}/review/',
      body: {
        "status": status,
        "delivery_date": delivary_date,
      },
      headers: NetworkConfig.getHeaders(type: RequestType.PATCH, needAuth: true),
    );


    final statusCode = value['statusCode'];
    final responseData = value['response'];

    if (statusCode == null) {
      return Left('خطأ في استلام البيانات، رمز الحالة غير موجود');
    }

    if (statusCode.toString()[0] != '2') {
      return Left('خطأ في استلام البيانات، رمز الحالة: $statusCode');
    }

    if (responseData == null) {
      return Left('حدث خطأ في استلام البيانات من السيرفر');
    }

    // responseData هو Map<String, dynamic> حسب الرد الأخير
    PatchProjectModel projects = PatchProjectModel.fromJson(responseData);

    return Right(projects);
  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}

}










