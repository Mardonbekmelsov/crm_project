import 'package:dio/dio.dart';
import 'package:millima/data/models/auth/social_login_request.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/utils/network/dio_client.dart';

abstract class AuthenticationServiceInterface {
  Future<AuthenticationResponse> login(LoginRequest request);
   Future<AuthenticationResponse> socialLogin(SocialLoginRequest request);
  Future<AuthenticationResponse> register(RegisterRequest request);
  Future<void> logout();
}

class AuthenticationService extends AuthenticationServiceInterface {
  final dio = DioClient.dio;

  @override
  Future<AuthenticationResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        '/login',
        data: request.toMap(),
      );

      if (response.data['success'] == false) {
        throw response.data['data'];
      }

      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      if (e.response?.data['success'] != null) {
        String error = '';
        e.response?.data['data'].forEach((key, value) {
          error = value;
        });
        throw (error);
      } else {
        throw e.response?.data;
      }
    } catch (e) {
      rethrow;
    }
  }

@override
   Future<AuthenticationResponse> socialLogin(SocialLoginRequest request) async {
    try {
      final response = await dio.post(
        '/social-login',
        data: request.toMap(),
      );
      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest request) async {
    try {
      final response = await dio.post(
        '/register',
        data: request.toMap(),
      );

      if (response.data['success'] == false) {
        String error = '';
        response.data['data'].forEach((key, value) {
          error = value[0];
        });
        throw error;
      }
      return AuthenticationResponse.fromMap(response.data['data']);
    } on DioException catch (e) {
      if (e.response?.data['success'] != null) {
        String error = '';
        e.response?.data['data'].forEach((key, value) {
          error = value[0];
        });
        throw (error);
      } else {
        throw e.response?.data;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('/logout');
    } on DioException catch (e) {
      throw (e.response?.data);
    } catch (e) {
      rethrow;
    }
  }
}
