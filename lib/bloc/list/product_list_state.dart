part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();
}

class ProductListInitial extends ProductListState {
  @override
  List<Object> get props => [];
}
