import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/home/home_bloc.dart';
import 'package:nike_store/data/repo/baner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';

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
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 100, top: 12),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Image.asset(
                          'assets/images/nike_logo.png',
                          height: 32,
                        );
                      case 1:
                        return Container();
                      default:
                        return Container();
                    }
                  },
                ),
              );
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.exception.message.toString()),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: Text('تلاش دوباره')),
                  ],
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
