import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/models/cart/cart_item_entity.dart';
import 'package:nike_store/models/login/login_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;

  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        final authInfo = event.authInfo;
        if (authInfo == null || authInfo.accessToken!.isEmpty) {
          emit(const CartAuthRequired());
        } else {
          await _loadCartItems(emit, event.isRefreshing);
        }
      } else if (event is CartDeleteButtonClicked) {
        try {
          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final cartItem = successState.cartItems.cartItems!.firstWhere(
                (element) => element.cartItemId == event.cartItemId);
            cartItem.deleteButtonLoading = true;
            emit(CartSuccess(successState.cartItems));
          }
          await Future.delayed(Duration(seconds: 4));
          await cartRepository.delete(event.cartItemId);

          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            successState.cartItems.cartItems!.removeWhere(
                (element) => element.cartItemId == event.cartItemId);
            if (successState.cartItems.cartItems!.isEmpty) {
              emit(const CartEmpty());
            } else {
              emit(calcPriceInfo(successState.cartItems));
            }
          }
        } catch (e) {}
      } else if (event is CartAuthInfoChanged) {
        if (event.authInfo == null || event.authInfo!.accessToken!.isEmpty) {
          emit(const CartAuthRequired());
        } else {
          if (state is CartAuthRequired) {
            await _loadCartItems(emit, false);
          }
        }
      } else if (event is IncreaseCountButtonClicked ||
          event is DecreaseCountButtonClicked) {
        try {
          int cartItemId = 0;
          if (event is IncreaseCountButtonClicked) {
            cartItemId = event.cartItemId;
          } else if (event is DecreaseCountButtonClicked) {
            cartItemId = event.cartItemId;
          }

          if (state is CartSuccess) {
            final successState = (state as CartSuccess);
            final cartItem = successState.cartItems.cartItems!
                .firstWhere((element) => element.cartItemId == cartItemId);
            cartItem.changeCountLoading = true;
            emit(CartSuccess(successState.cartItems));

            await Future.delayed(Duration(seconds: 4));
            int newCount = event is IncreaseCountButtonClicked
                ? cartItem.count! + 1
                : cartItem.count! - 1;
            await cartRepository.changeCount(cartItemId, newCount);

            successState.cartItems.cartItems!
                .firstWhere((element) => element.cartItemId == cartItemId)
              ..count = newCount
              ..changeCountLoading = false;
            ;
            emit(calcPriceInfo(successState.cartItems));
          }
        } catch (e) {}
      }
    });
  }

  Future<void> _loadCartItems(
      Emitter<CartState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CartLoading());
      }

      final result = await cartRepository.getAll();
      if (result.cartItems!.isEmpty) {
        emit(const CartEmpty());
      } else {
        emit(CartSuccess(result));
      }
    } catch (e) {
      emit(CartError(AppException()));
    }
  }

  CartSuccess calcPriceInfo(CartItems cartItems) {
    int totalPrice = 0;
    int payablePrice = 0;
    int shippingCost = 0;
    cartItems.cartItems!.forEach((element) {
      totalPrice += element.product!.previusPrice! * element.count!;
      payablePrice += element.product!.price! * element.count!;
    });

    shippingCost = payablePrice >= 250000 ? 0 : 30000;
    cartItems.payablePrice = payablePrice;
    cartItems.totalPrice = totalPrice;
    cartItems.shippingCost = shippingCost;
    return CartSuccess(cartItems);
  }
}
