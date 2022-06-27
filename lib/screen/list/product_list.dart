import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/list/product_list_bloc.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/models/product/product.dart';
import 'package:nike_store/widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({
    Key? key,
    required this.sort,
  }) : super(key: key);
  final int sort;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType {
  grid,
  list,
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? bloc;
  ViewType viewType = ViewType.grid;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc!.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کفش های ورزشی'),
      ),
      body: BlocProvider<ProductListBloc>(
        create: (context) {
          bloc = ProductListBloc(productRepository)
            ..add(ProductListStarted(widget.sort));

          return bloc!;
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1,
                          ),
                        ),
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            blurRadius: 10,
                          ),
                        ]),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 250,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Column(
                                children: [
                                  Text(
                                    'انتخاب مرتب سازی',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: ProductSort.names.length,
                                      itemBuilder: (context, index) {
                                        final selectedSortIndex = state.sort;
                                        return InkWell(
                                          onTap: () {
                                            bloc!.add(
                                              ProductListStarted(index),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 30),
                                            child: Row(
                                              children: [
                                                Text(
                                                  ProductSort.names[index],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                index == selectedSortIndex
                                                    ? Icon(
                                                        Icons.check_circle,
                                                        size: 22,
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  width: 50,
                                  child: TextButton(
                                    onPressed: () {

                                    },
                                    child: Icon(
                                      CupertinoIcons.sort_down,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'مرتب سازی',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    Text(
                                      ProductSort.names[state.sort],
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            color: Theme.of(context).dividerColor,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 50,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  viewType = viewType == ViewType.grid
                                      ? ViewType.list
                                      : ViewType.grid;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.square_grid_2x2,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.65,
                          crossAxisCount: viewType == ViewType.grid ? 2 : 1),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductItem(
                          product: products[index],
                          borderRadius: BorderRadius.circular(5),
                        );
                      },
                    ),
                  ),
                ],
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
