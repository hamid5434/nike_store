part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductAddToCartButtonLoading extends ProductState {}

class ProductAddToCartButtonError extends ProductState {
  final AppException exception;

  const ProductAddToCartButtonError(this.exception);

  @override
  List<Object> get props => [exception];
}

class ProductAddToCartButtonSuccess extends ProductState {}
