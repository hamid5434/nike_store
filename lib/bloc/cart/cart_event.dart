part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshing;

  const CartStarted(this.authInfo, {this.isRefreshing = false});

  @override
  List<Object?> get props => [authInfo];
}

class CartDeleteButtonClicked extends CartEvent {
  final int cartItemId;

  const CartDeleteButtonClicked(this.cartItemId);

  @override
  List<Object?> get props => [cartItemId];
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChanged(this.authInfo);

  @override
  List<Object?> get props => [authInfo];
}

class IncreaseCountButtonClicked extends CartEvent {
  final int cartItemId;

  const IncreaseCountButtonClicked(this.cartItemId);

  @override
  List<Object?> get props => [cartItemId];
}

class DecreaseCountButtonClicked extends CartEvent {
  final int cartItemId;

  const DecreaseCountButtonClicked(this.cartItemId);

  @override
  List<Object?> get props => [cartItemId];
}