import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/models/cart/cart_response.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository repositoy;

  ProductBloc(this.repositoy) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClick) {
        try {
          emit(ProductAddToCartButtonLoading());
          //await Future.delayed(Duration(seconds: 3));
          CartResponse result = await repositoy.add(event.productId);
          await cartRepository.count();
          emit(ProductAddToCartButtonSuccess());
        } catch (e) {
          emit(ProductAddToCartButtonError(
              AppException(statusCode: 1, message: e.toString())));
        }
      }
    });
  }
}
