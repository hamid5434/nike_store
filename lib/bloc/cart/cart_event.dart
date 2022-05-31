part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;

  CartStarted(this.authInfo);

  @override
  // TODO: implement props
  List<Object?> get props => [authInfo];
}

class CartDeleteButtonClicked extends CartEvent {
  final int cartItemId;

  CartDeleteButtonClicked(this.cartItemId);

  @override
  // TODO: implement props
  List<Object?> get props => [cartItemId];
}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  CartAuthInfoChanged(this.authInfo);

  @override
  // TODO: implement props
  List<Object?> get props => [authInfo];
}
