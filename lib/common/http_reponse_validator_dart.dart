
import 'package:dio/dio.dart';
import 'package:nike_store/common/exceptions.dart';

mixin HttpResponseValidator {
  validateResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
    } else {
      AppException(
        message: response.statusMessage!,
        statusCode: response.statusCode!,
      );
    }
  }
}