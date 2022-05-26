import 'package:dio/dio.dart';
import 'package:nike_store/common/constants.dart';
import 'package:nike_store/common/http_reponse_validator_dart.dart';
import 'package:nike_store/models/login/login_model.dart';

abstract class IAuthDataSource {
  Future<LoginModel> login(
      {required String username, required String password});

  Future<LoginModel> register(
      {required String username, required String password});

  Future<LoginModel> refreshToken({required String token});
}

class AuthDataSource with HttpResponseValidator implements IAuthDataSource {
  final Dio httpClient;

  AuthDataSource({required this.httpClient});

  @override
  Future<LoginModel> login(
      {required String username, required String password}) async {
    final response = await httpClient.post('auth/token', data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "username": username,
      "password": password
    });
    validateResponse(response);
    return LoginModel.fromJson(response.data);
  }

  @override
  Future<LoginModel> refreshToken({required String token}) async {
    final response = await httpClient.post('auth/token', data: {
      "grant_type": "refresh_token",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "refresh_token": token,
    });
    validateResponse(response);
    return LoginModel.fromJson(response.data);
  }

  @override
  Future<LoginModel> register(
      {required String username, required String password}) async {
    final response = await httpClient
        .post('user/register', data: {"email": username, "password": password});
    validateResponse(response);
    final response1 = await login(username: username, password: password);

    return response1;
  }
}
