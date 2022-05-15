import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/product_data_source.dart';
import 'package:nike_store/models/product/product.dart';

final productRepository = ProductRepository(
    dataSource: ProductRemoteDataSource(httpClient: httpClient));

abstract class IProductRepositoy {
  Future<List<ProductEntity>> getAll(int sort);

  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepositoy {
  final IProductDataSource dataSource;

  ProductRepository({required this.dataSource});

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final products = dataSource.getAll(sort);
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final products = dataSource.search(searchTerm);
    return products;
  }
}
