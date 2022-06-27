import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/models/product/product.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepositoy repositoy;

  ProductListBloc(this.repositoy) : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListStarted) {
        emit(ProductListLoading());
        final result = await repositoy.getAll(event.sort);
        emit(ProductListSuccess(result, event.sort, ProductSort.names));
        try {} catch (e) {
          emit(ProductListError(
              AppException(message: e.toString(), statusCode: 1)));
        }
      }
    });
  }
}
