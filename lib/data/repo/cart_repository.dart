import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/cart_data_source.dart';
import 'package:nike_store/models/cart/cart_item_entity.dart';
import 'package:nike_store/models/cart/cart_response.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository extends ICartDataSource {
  // Future<CartResponse> add(int productId);
  //
  // Future<CartResponse> changeCount(int cartItemId, int count);
  //
  // Future<void> delete(int cartItemId);
  //
  // Future<int> count(int cartItemId);
  //
  // Future<List<CartItemEntity>> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);

  @override
  Future<CartResponse> add(int productId) {
    return dataSource.add(productId);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count(int cartItemId) {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
