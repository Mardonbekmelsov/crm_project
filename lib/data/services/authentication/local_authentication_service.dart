// ignore_for_file: avoid_print

import 'package:millima/data/models/auth/authentication_response.dart';
import 'package:millima/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthenticationService {
  final prefs = getIt.get<SharedPreferences>();
  final String _authKey = "token";

  Future<void> saveAuth(AuthenticationResponse data) async {
    print(data);
    prefs.setString(_authKey, data.toJson());
  }

  AuthenticationResponse? getAuth() {
    final data = prefs.getString(_authKey);
    print(data);
    return data != null ? AuthenticationResponse.fromJson(data) : null;
  }

  Future<void> deleteAuth() async {
    await prefs.remove(_authKey);
  }
}
