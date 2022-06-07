import 'package:dio/dio.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/common/http_reponse_validator_dart.dart';
import 'package:nike_store/models/product/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);

  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource
    with HttpResponseValidator
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource({required this.httpClient});

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('/product/list?sort=$sort');
    validateResponse(response);
    //hh
    List<ProductEntity> products = ProductEntitys.fromJson(response.data).list;
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('/product/search?sort=$searchTerm');
    validateResponse(response);
    List<ProductEntity> products = ProductEntitys.fromJson(response.data).list;
    return products;
  }
}
