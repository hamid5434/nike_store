import 'package:dio/dio.dart';
import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/common/http_reponse_validator_dart.dart';
import 'package:nike_store/models/cart/cart_item_entity.dart';
import 'package:nike_store/models/cart/cart_response.dart';

abstract class ICartDataSource {
  Future<CartResponse> add(int productId);

  Future<CartResponse> changeCount(int cartItemId, int count);

  Future<void> delete(int cartItemId);

  Future<int> count(int cartItemId);

  Future<CartItems> getAll();
}

class CartRemoteDataSource
    with HttpResponseValidator
    implements ICartDataSource {
  final Dio dio;

  CartRemoteDataSource(this.dio);

  @override
  Future<CartResponse> add(int productId) async {
    final response = await httpClient.post('cart/add', data: {
      "product_id": productId,
    });

    validateResponse(response);

    return CartResponse.fromJson(response.data);
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
  Future<void> delete(int cartItemId) async {
    await httpClient.post('cart/remove', data: {
      "cart_item_id": cartItemId,
    });
  }

  @override
  Future<CartItems> getAll() async {
    final response = await httpClient.get('cart/list');
    validateResponse(response);
    CartItems cartItems = CartItems.fromJson(response.data);
    return cartItems;
  }
}
