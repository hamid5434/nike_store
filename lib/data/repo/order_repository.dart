import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/order_data_source.dart';
import 'package:nike_store/models/order/order.dart';
import 'package:nike_store/models/payment/payment_receipt_data.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {
  //Future<CreateOrderResult> create(CreateOrderParams params);
}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource dataSource;

  OrderRepository(this.dataSource);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) async {
    return await dataSource.create(params);
  }

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) async {
    return await dataSource.getPaymentReceipt(orderId);
  }

  @override
  Future<List<OrderEntity>> getOrders() async{
    return await dataSource.getOrders();
  }
}
