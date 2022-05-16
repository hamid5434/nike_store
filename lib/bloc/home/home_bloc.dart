import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/baner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/models/baner/Baner.dart';
import 'package:nike_store/models/product/product.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBanerRepositoy banerRepositoy;
  final IProductRepositoy productRepositoy;

  HomeBloc({
    required this.banerRepositoy,
    required this.productRepositoy,
  }) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          //throw Exception('error');
          print('Start');
          final banners = await bannerRepository.getAll();
          final latestProducts =
              await productRepositoy.getAll(ProductSort.lastest);
          final popularProducts =
              await productRepositoy.getAll(ProductSort.populer);
          print('end');
          emit(
            HomeSuccess(
              banners: banners,
              latestProducts: latestProducts,
              popularProducts: popularProducts,
            ),
          );
        } catch (ex) {
          print('error');
          emit(
            HomeError(
              exception: ex is AppException
                  ? ex
                  : AppException(message: ex.toString(), statusCode: 1),
            ),
          );
        }
      }
    });
  }
}
