
import 'package:dio/dio.dart';
import 'package:nike_store/common/http_reponse_validator_dart.dart';
import 'package:nike_store/models/baner/Baner.dart';

abstract class IBanerDataSource {
  Future<List<BanerEntity>> getAll();
}

class BannerRemoteDataSource   with HttpResponseValidator implements IBanerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource({required this.httpClient});
  @override
  Future<List<BanerEntity>> getAll()async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);
    List<BanerEntity> banners = BanerEntitys.fromJson(response.data).list;
    return banners;
  }

}