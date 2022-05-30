part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;

  CartStarted(this.authInfo);
}
class CartDeleteButton extends CartEvent {}

class CartAuthInfoChanged extends CartEvent {
  final AuthInfo? authInfo;

  CartAuthInfoChanged(this.authInfo);
}
