import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/models/order/order.dart';

part 'shipping_event.dart';

part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository repository;

  ShippingBloc(this.repository) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      if (event is ShippingCreateOrder) {
        try {
          emit(ShippingLoading());
          await Future.delayed(Duration(seconds: 3));
          final result = await repository.create(event.params);
          emit(ShippingSuccess(result));
        } catch (e) {
          emit(ShippingError(e is AppException ? e : AppException()));
        }
      }
    });
  }
}
