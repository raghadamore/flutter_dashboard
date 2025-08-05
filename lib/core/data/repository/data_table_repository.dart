import 'package:dartz/dartz.dart';
import 'package:task_P2/core/data/models/common_response.dart';
import 'package:task_P2/core/data/models/data_model.dart';

import 'package:task_P2/core/data/models/product_model.dart';
import 'package:task_P2/core/enums/request_type.dart';
import 'package:task_P2/core/utils/network_util.dart';


class DataTableRepository {
  Future<Either<String, List<DataModel>>> getData() async {
    try {
      return await  NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/users',
      ).then((value) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          List<DataModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(DataModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  
}
