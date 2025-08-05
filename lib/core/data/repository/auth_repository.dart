import 'package:dartz/dartz.dart';
import 'package:task_P2/core/data/models/common_response.dart';
import 'package:task_P2/core/data/models/forget_model.dart';
import 'package:task_P2/core/data/models/logout_model.dart';
import 'package:task_P2/core/data/models/otp_model.dart';
import 'package:task_P2/core/data/models/refresh_model.dart';
import 'package:task_P2/core/data/models/reset_password.dart';

import 'package:task_P2/core/data/models/user_model.dart';
import 'package:task_P2/core/data/network/network_config.dart';
import 'package:task_P2/core/enums/request_type.dart';
import 'package:task_P2/core/utils/network_util.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class AuthRepository {
Future<Either<String, UserModel>> login({
  required String email,
  required String password,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.POST,
      route: 'dashboard/auth/signin/',
      body: {
        "email": email,
        "password": password,
      },
      headers: NetworkConfig.getHeaders(type: RequestType.POST),
    );

    print('Full response: $value');

    final responseData = value['response']; // دايمًا يحتوي على الرد الحقيقي
    final statusCode = value['statusCode'];

    // حالة الخطأ
    if (!statusCode.toString().startsWith('2')) {
      final errors = responseData['non_field_errors'];
      if (errors is List && errors.isNotEmpty && errors[0] != null) {
        return Left(errors[0].toString());
      }

      // خطأ بدون تفاصيل واضحة
      return Left(responseData['message'] ?? 'حدث خطأ غير معروف');
    }

    // حالة النجاح: البيانات داخل responseData
    return Right(UserModel.fromJson(responseData));

  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}
 Future<Either<String, RefreshTokenModel>> updateFcmToken({
  required String refreshToken, 
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.POST,
      route: 'api/token/refresh/',
      body: {
        "refresh": refreshToken,   // هنا: كلمة "refresh" مش "token"
      },
      headers: NetworkConfig.getHeaders(type: RequestType.POST),
    );

    print('Full response: $value');

    final responseData = value['response']; // دايمًا يحتوي على الرد الحقيقي
    final statusCode = value['statusCode'];

    // حالة الخطأ
    if (!statusCode.toString().startsWith('2')) {
      final errors = responseData['non_field_errors'];
      if (errors is List && errors.isNotEmpty && errors[0] != null) {
        return Left(errors[0].toString());
      }

      // خطأ بدون تفاصيل واضحة
      return Left(responseData['message'] ?? 'حدث خطأ غير معروف');
    }

    // حالة النجاح: البيانات داخل responseData
    return Right(RefreshTokenModel.fromJson(responseData));

  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}








 

  Future<Either<String, ForgetModel>> forgetPassword({
  required String email,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.POST,
      
      route: 'dashboard/users/password/forgot/',
      body: {
        "email": email,
        
      },
      headers: NetworkConfig.getHeaders(type: RequestType.POST),
    );

    print('Full response: $value');

    final responseData = value['response'];

    if (responseData == null) {
      return Left('حدث خطأ في استلام البيانات من السيرفر');
    }

    // إذا وجدت أخطاء في non_field_errors
    if (responseData['email'] != null) {
      final errors = responseData['email'];
      if (errors is List && errors.isNotEmpty && errors[0] != null) {
        return Left(errors[0].toString());
      }
    }

    // بخلاف ذلك، نفترض responseData هي بيانات المستخدم الناجح
   
    return Right(ForgetModel.fromJson(responseData));
  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}

 Future<Either<String, OtpModel>> confirmOTP({
  required String email,
  required String otp,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.POST,
      route: 'api/user/password/confirm-otp/',
      body: {
        "email": email,
        "otp": otp,
      },
      headers: NetworkConfig.getHeaders(type: RequestType.POST),
    );

    print('Full response: $value');

    final responseData = value['response']; // دايمًا يحتوي على الرد الحقيقي
    final statusCode = value['statusCode'];

    // حالة الخطأ
    if (!statusCode.toString().startsWith('2')) {
      final errors = responseData['non_field_errors'];
      if (errors is List && errors.isNotEmpty && errors[0] != null) {
        return Left(errors[0].toString());
      }

      // خطأ بدون تفاصيل واضحة
      return Left(responseData['message'] ?? 'حدث خطأ غير معروف');
    }

    // حالة النجاح: البيانات داخل responseData
    return Right(OtpModel.fromJson(responseData));

  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}
 Future<Either<String, ResetPasswordModel>> resetPassword({
  required String email,
  required String otp,
  required String newPassword,
  required String confirmPassword,

}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.POST,
      route: 'dashboard/users/password/reset/',
      body: {
        "email": email,
        "otp": otp,
        "new_password":newPassword,
        "confirm_password":confirmPassword
      },
      headers: NetworkConfig.getHeaders(type: RequestType.POST),
    );

    print('Full response: $value');

    final responseData = value['response']; // دايمًا يحتوي على الرد الحقيقي
    final statusCode = value['statusCode'];

    // حالة الخطأ
    if (!statusCode.toString().startsWith('2')) {
      final errors = responseData['non_field_errors'];
      if (errors is List && errors.isNotEmpty && errors[0] != null) {
        return Left(errors[0].toString());
      }

      // خطأ بدون تفاصيل واضحة
      return Left(responseData['message'] ?? 'حدث خطأ غير معروف');
    }

    // حالة النجاح: البيانات داخل responseData
    return Right(ResetPasswordModel.fromJson(responseData));

  } catch (e) {
    return Left('خطأ في الاتصال: ${e.toString()}');
  }
}
Future<Either<String, LogoutModel>> logout({
  required String refresh,
}) async {
  try {
    final value = await NetworkUtil.sendRequest(
      type: RequestType.POST,
      route: 'dashboard/users/logout/',
      body: {
        "refresh": refresh,
      },
      headers: NetworkConfig.getHeaders(type: RequestType.POST, needAuth: true),
    );

    print('Logout response: $value');

    final responseData = value['response'];
    final statusCode = value['statusCode'];

    if (statusCode == 205) {
      // ✅ 205 = تسجيل خروج ناجح حتى لو الرد فاضي
      return Right(LogoutModel(message: "تم تسجيل الخروج بنجاح"));
    }

    if (!statusCode.toString().startsWith('2')) {
      if (responseData is Map<String, dynamic>) {
        final message = responseData['message'] ?? 'حدث خطأ أثناء تسجيل الخروج';
        return Left(message.toString());
      } else {
        return Left('فشل تسجيل الخروج: الرد غير مفهوم');
      }
    }

   if (responseData == null || responseData.toString().isEmpty) {
  // ✅ الرد فاضي، بس طالما statusCode هو 205، نعتبره نجاح
  return Right(LogoutModel(message: "تم تسجيل الخروج بنجاح"));
}

if (responseData is Map<String, dynamic>) {
  return Right(LogoutModel.fromJson(responseData));
} else {
  return Left('الرد غير متوقع من الخادم');
}

  } catch (e) {
    return Left('خطأ في الاتصال أثناء تسجيل الخروج: ${e.toString()}');
  }
}




}

