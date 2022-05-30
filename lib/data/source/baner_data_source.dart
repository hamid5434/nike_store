import 'package:dio/dio.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/common/http_reponse_validator_dart.dart';
import 'package:nike_store/models/baner/Baner.dart';

abstract class IBanerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBanerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource({required this.httpClient});

  @override
  Future<List<BannerEntity>> getAll() async {
    try {
      final response = await httpClient.get('banner/slider');
      validateResponse(response);
      List<BannerEntity> banners = BannerEntitys.fromJson(response.data).list;
      return banners;
    } catch (e) {
      throw AppException();
    }
  }
}
