import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:task_P2/core/data/models/common_response.dart';
import 'package:task_P2/core/data/models/project_model.dart';
import 'package:task_P2/core/data/models/status_and_type_project_model.dart';
import 'package:task_P2/core/data/network/network_config.dart';
import 'package:task_P2/core/enums/request_type.dart';
import 'package:task_P2/core/utils/network_util.dart';

class ProjectRepository {
  Future<Either<String, List<ProjectModel>>> getAllProjects() async {
    try {
      final value = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: 'dashboard/requests/all/',
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

      // هنا responseData هي List<dynamic>
      List<ProjectModel> projects =
          (responseData as List).map((e) => ProjectModel.fromJson(e)).toList();

      return Right(projects);
    } catch (e) {
      print('خطأ في الاتصال: ${e.toString()}');
      return Left('خطأ في الاتصال: ${e.toString()}');
    }
  }

  Future<Either<String, List<StatusAndTypeProjectModel>>> getAllProjectsByStatusAndType({
  required String status,
  required String type,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.GET,
      route: 'dashboard/projects/',
      params: {"status": status, "project_type": type},
      headers: NetworkConfig.getHeaders(type: RequestType.GET, needAuth: true),
    );

    print("value: ${jsonEncode(value)}"); // ✅ للتصحيح

    final statusCode = value['statusCode'];
    final responseData = value['response'];

    if (statusCode == null || responseData == null) {
      return Left('حدث خطأ في استلام البيانات من السيرفر');
    }

    if (statusCode.toString()[0] != '2') {
      return Left('خطأ في استلام البيانات، رمز الحالة: $statusCode');
    }

    List<StatusAndTypeProjectModel> projects = (responseData as List)
        .map((e) => StatusAndTypeProjectModel.fromJson(e))
        .toList();

    return Right(projects);
  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}

}
