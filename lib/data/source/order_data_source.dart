import 'package:dio/dio.dart';
import 'package:nike_store/models/order/order.dart';

abstract class IOrderDataSource {
  Future<CreateOrderResult> create(CreateOrderParams params);
}

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio httpClient;

  OrderRemoteDataSource(this.httpClient);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) async {
    final response = await httpClient.post('order/submit', data: {
      "first_name": params.firstName,
      "last_name": params.lastName,
      "postal_code": params.postalCode,
      "mobile": params.phoneNumber,
      "address": params.address,
      "payment_method": params.paymentMethod == PaymentMethod.online
          ? 'online'
          : 'cash_on_delivery',
    });
    return CreateOrderResult.fromJson(response.data);
  }
}
