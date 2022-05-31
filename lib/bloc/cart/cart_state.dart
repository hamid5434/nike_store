part of 'cart_bloc.dart';

abstract class CartState  {
  const CartState();
}

class CartLoading extends CartState {

}

class CartSuccess extends CartState {
  final CartItems cartItems;

  const CartSuccess(this.cartItems);

}

class CartError extends CartState {
  final AppException exception;

  const CartError(this.exception);

}

class CartEmpty extends CartState {
  const CartEmpty();

}

class CartAuthRequired extends CartState {
  const CartAuthRequired();


}
