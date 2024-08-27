// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:millima/data/services/authentication/local_authentication_service.dart';
import 'package:millima/utils/locator.dart';

class DioClient {
  static final _dio =
      Dio(BaseOptions(baseUrl: "http://millima.flutterwithakmaljon.uz/api"))
        ..interceptors.add(NetworkInterceptor());

  static Dio get dio {
    return _dio;
  }
}

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final auth = getIt.get<LocalAuthenticationService>().getAuth();

    print("auth : $auth");

    if (auth != null) {
      options.headers = {
        "Authorization": "Bearer ${auth.token}",
      };
    }

    super.onRequest(options, handler);
  }
}
