import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/list/product_list_bloc.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    Key? key,
    required this.sort,
  }) : super(key: key);
  final int sort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کفش های ورزشی'),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (context) =>
            ProductListBloc(productRepository)..add(ProductListStarted(sort)),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.65, crossAxisCount: 2),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: products[index],
                    borderRadius: BorderRadius.circular(5),
                  );
                },
              );
            } else if (state is ProductListError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is ProductListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else {
              return const Center(
                child: Text('state not supported'),
              );
            }
          },
        ),
      ),
    );
  }
}
