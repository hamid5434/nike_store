import 'package:nike_store/models/product/product.dart';

class CreateOrderResult {
  final int orderId;
  final String bankGatewayUrl;

  CreateOrderResult(this.orderId, this.bankGatewayUrl);

  CreateOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}

class CreateOrderParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final PaymentMethod paymentMethod;

  CreateOrderParams(
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.postalCode,
    this.address,
    this.paymentMethod,
  );
}

enum PaymentMethod {
  online,
  cashOnDelivery,
}

class OrderEntity {
  int? id;
  int? payablePrice;
  List<ProductEntity>? items;

  OrderEntity(
      {required this.id, required this.payablePrice, required this.items});

  OrderEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payablePrice = json['payable'];
    if (json['order_items'] != null) {
      items = <ProductEntity>[];
      json['order_items'].forEach((v) {
        items!.add(ProductEntity.fromJson(v['product']));
      });
    }
  }
}
