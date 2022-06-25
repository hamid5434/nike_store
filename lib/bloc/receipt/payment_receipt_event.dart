part of 'payment_receipt_bloc.dart';

abstract class PaymentReceiptEvent extends Equatable {
  const PaymentReceiptEvent();

  @override
  List<Object?> get props => [];
}

class PaymentReceiptStart extends PaymentReceiptEvent {
  final int orderId;

  const PaymentReceiptStart(this.orderId);
  @override
  List<Object?> get props => [orderId];
}
