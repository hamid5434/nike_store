import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/models/order/order.dart';

part 'order_history_event.dart';

part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final IOrderRepository repository;

  OrderHistoryBloc(this.repository) : super(OrderHistoryLoading()) {
    on<OrderHistoryEvent>((event, emit) async {
      if (event is OrderHistoryStarted) {
        try {
          emit(
            OrderHistoryLoading(),
          );
          final result = await repository.getOrders();
          emit(
            OrderHistorySuccess(result),
          );
        } catch (e) {
          emit(
            OrderHistoryError(
              e is AppException ? e : AppException(),
            ),
          );
        }
      }
    });
  }
}
