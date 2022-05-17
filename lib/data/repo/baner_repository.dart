import 'package:dio/dio.dart';
import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/baner_data_source.dart';
import 'package:nike_store/data/source/product_data_source.dart';
import 'package:nike_store/models/baner/Baner.dart';
import 'package:nike_store/models/product/product.dart';

final bannerRepository =
    BanerRepository(dataSource: BannerRemoteDataSource(httpClient: httpClient));

abstract class IBanerRepositoy {
  Future<List<BannerEntity>> getAll();
}

class BanerRepository implements IBanerRepositoy {
  final IBanerDataSource dataSource;

  BanerRepository({required this.dataSource});

  @override
  Future<List<BannerEntity>> getAll() async {
    final products = dataSource.getAll();
    return products;
  }
}
