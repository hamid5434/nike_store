part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartSuccess extends CartState {
  final CartItems cartItems;

  const CartSuccess(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartError extends CartState {
  final AppException exception;

  const CartError(this.exception);

  @override
  List<Object> get props => [exception];
}

class CartEmpty extends CartState {
  const CartEmpty();

  @override
  List<Object> get props => [];
}

class CartAuthRequired extends CartState {
  const CartAuthRequired();

  @override
  List<Object> get props => [];
}
