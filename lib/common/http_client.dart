import 'package:dio/dio.dart';
import 'package:nike_store/data/repo/auth_repository.dart';

final httpClient =
    Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          final auth = AuthRepository.authChangeNotifier.value;
          if (auth != null && auth.accessToken!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer ${auth.accessToken}';
          }

            handler.next(options);
        },
      ));
