import 'package:dio/dio.dart';

const baseurl = 'http://localhost:8000';

Dio client() {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseurl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  // Interceptor
  dio.interceptors.add(auth());

  return dio;
}

Interceptor auth() {
  return InterceptorsWrapper(onRequest: (options, handler) {
    return handler.next(options);
  }, onResponse: (response, handler) {
    return handler.next(response);
  }, onError: (DioError e, handler) {
    return handler.next(e);
  });
}
