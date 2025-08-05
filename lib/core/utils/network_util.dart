import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_P2/core/data/repository/auth_repository.dart';
import 'package:task_P2/core/enums/request_type.dart';
import 'package:task_P2/ui/shared/shared_widgets/routes/routers.dart';
import 'package:task_P2/ui/shared/utlis.dart';

class NetworkUtil {
  static String baseUrl = 'sssdsy.pythonanywhere.com';

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String route,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    var url = Uri.https(baseUrl, route, params);
    print('Request URL: $url');

    http.Response response;

    // تنفيذ الطلب الأولي حسب النوع
    switch (type) {
      case RequestType.GET:
        response = await http.get(url, headers: headers);
        break;
      case RequestType.POST:
        response = await http.post(url, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.DELETE:
        response = await http.delete(url, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.PUT:
        response = await http.put(url, body: jsonEncode(body), headers: headers);
        break;
      case RequestType.PATCH:
        response = await http.patch(url, body: jsonEncode(body), headers: headers);
        break;
    }

    // إذا انتهت الجلسة (401 Unauthorized)
    if (response.statusCode == 401) {
      final refreshToken = storage.getRefreshTokenInfo();

      if (refreshToken == null || refreshToken.trim().isEmpty) {
        print("⚠️ لا يوجد توكن تحديث، توجيه المستخدم لتسجيل الدخول");
        BotToast.showText(text: "انتهت الجلسة. يرجى تسجيل الدخول مجددًا");
        Get.offAllNamed(TRoutes.login);
        return {
          'statusCode': 401,
          'response': {'message': 'No refresh token found'}
        };
      }

      final tokenResult =
          await AuthRepository().updateFcmToken(refreshToken: refreshToken);

      return await tokenResult.fold((error) async {
        BotToast.showText(text: "انتهت الجلسة. يرجى تسجيل الدخول مجددًا");
        Get.offAllNamed(TRoutes.login);
        return {
          'statusCode': 401,
          'response': {'message': error}
        };
      }, (newToken) async {
        // تحديث الهيدر بالتوكن الجديد
storage.setTokenInfo(newToken.access!); // خزني فقط access token الجديد
        

        // إعادة الطلب بالتوكن الجديد
        switch (type) {
          case RequestType.GET:
            response = await http.get(url, headers: headers);
            break;
          case RequestType.POST:
            response = await http.post(url, body: jsonEncode(body), headers: headers);
            break;
          case RequestType.DELETE:
            response = await http.delete(url, body: jsonEncode(body), headers: headers);
            break;
          case RequestType.PUT:
            response = await http.put(url, body: jsonEncode(body), headers: headers);
            break;
        }

        return {
          'statusCode': response.statusCode,
          'response': _decodeResponse(response)
        };
      });
    }

    // تحليل الاستجابة العادية
    return {
      'statusCode': response.statusCode,
      'response': _decodeResponse(response)
    };
  }

  static dynamic _decodeResponse(http.Response response) {
    try {
      String decodedBody = Utf8Codec().decode(response.bodyBytes);
      return jsonDecode(decodedBody);
    } catch (e) {
      return response.body;
    }
  }}