import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/models/payment/payment_receipt_data.dart';

part 'payment_receipt_event.dart';

part 'payment_receipt_state.dart';

class PaymentReceiptBloc
    extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  final IOrderRepository repository;

  PaymentReceiptBloc(this.repository) : super(PaymentReceiptLoading()) {
    on<PaymentReceiptEvent>((event, emit) async {

      if (event is PaymentReceiptStart) {
        try {
          emit(PaymentReceiptLoading());
          final response = await repository.getPaymentReceipt(event.orderId);
          emit(PaymentReceiptSuccess(response));
        } catch (e) {
          emit(PaymentReceiptError(AppException()));
        }
      }
    });
  }
}
