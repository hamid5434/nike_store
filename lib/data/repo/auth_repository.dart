import 'package:flutter/material.dart';
import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/auth_data_source.dart';
import 'package:nike_store/models/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthDataSource(httpClient: httpClient));

abstract class IAuthRepository {
  Future<void> login({required String username, required String password});

  Future<AuthInfo> register(
      {required String username, required String password});

  Future<void> refreshToken();

  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);

  AuthRepository(this.dataSource);

  @override
  Future<void> login(
      {required String username, required String password}) async {
    final AuthInfo loginModel =
        await dataSource.login(username: username, password: password);
    await _persistAuthToken(loginModel: loginModel);
    debugPrint("access token is: " + loginModel.accessToken!);
  }

  @override
  Future<void> refreshToken() async {
    if (authChangeNotifier.value != null) {
      final AuthInfo loginModel = await dataSource.refreshToken(
          token: authChangeNotifier.value!.refreshToken!);
      debugPrint('refresh token is22: ${loginModel.refreshToken}');
      _persistAuthToken(loginModel: loginModel);
    }
  }

  @override
  Future<AuthInfo> register(
      {required String username, required String password}) async {
    final AuthInfo loginModel =
        await dataSource.register(username: username, password: password);
    debugPrint("refresh token is: " + loginModel.refreshToken!);
    return loginModel;
  }

  Future<void> _persistAuthToken({required AuthInfo loginModel}) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('access_token', loginModel.accessToken!);
    await prefs.setString('refresh_token', loginModel.refreshToken!);

    await loadAuthInfo();
  }

  Future loadAuthInfo() async {
    final prefs = await SharedPreferences.getInstance();

    String access_token = await prefs.getString('access_token') ?? '';
    String refresh_token = await prefs.getString('refresh_token') ?? '';

    if (access_token.isNotEmpty && refresh_token.isNotEmpty) {
      authChangeNotifier.value =
          AuthInfo(accessToken: access_token, refreshToken: refresh_token);
    }
  }

  @override
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    authChangeNotifier.value = null;
  }
}
