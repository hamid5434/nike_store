part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartStarted extends CartEvent {}
