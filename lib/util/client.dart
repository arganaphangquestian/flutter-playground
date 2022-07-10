import 'package:dio/dio.dart';
import 'package:flutter_playground/page/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import 'persistance.dart';

const baseurl = 'http://localhost:8000';

Dio client() {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseurl,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Get.find<AppPref>().token.val}',
      },
    ),
  );
  // Interceptor
  dio.interceptors.add(auth(dio));

  return dio;
}

Interceptor auth(Dio dio) {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      return handler.next(options);
    },
    onResponse: (response, handler) {
      return handler.next(response);
    },
    onError: (DioError e, handler) async {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        final tokenApp = Get.find<AppPref>().token;
        try {
          final response = await dio.post('/refresh-token');
          final token = response.data['data']['token'];
          tokenApp.val = token;
          final cloneReq = await dio.request(
            e.requestOptions.path,
            options: Options(
              method: e.requestOptions.method,
              headers: e.requestOptions.headers,
            ),
            data: e.requestOptions.data,
            queryParameters: e.requestOptions.queryParameters,
          );
          return handler.resolve(cloneReq);
        } catch (e) {
          tokenApp.val = '';
          Get.offAllNamed(LoginPage.routeName);
        }
      }
      return handler.next(e);
    },
  );
}
