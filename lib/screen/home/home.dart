import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/home/home_bloc.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/baner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/screen/home/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            banerRepositoy: bannerRepository,
            productRepositoy: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              return SafeArea(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100, top: 12),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/nike_logo.png',
                            height: 32,
                          ),
                        );
                      case 1:
                        return Container();
                      case 2:
                        return SizedBox(
                          height: 200,
                          child: BannerSlider(banners: state.banners),
                        );
                      case 3:
                        return HorizontalProduct(
                            title: 'جدیدترین',
                            onTab: () {},
                            products: state.latestProducts);
                      case 4:
                        return HorizontalProduct(
                            title: 'پر بازدیدترین',
                            onTab: () {},
                            products: state.popularProducts);
                      default:
                        return Container();
                    }
                  },
                ),
              );
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.exception.message.toString()),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(HomeRefresh());
                          },
                          child: const Text('تلاش دوباره'),),
                    ],
                  ),
                ),
              );
            } else {
              throw Exception('state not support');
            }
          },
        ),
      ),
    );
  }
}
