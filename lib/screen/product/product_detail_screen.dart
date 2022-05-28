import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/product/product_bloc.dart';
import 'package:nike_store/common/theme.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/models/product/product.dart';
import 'package:nike_store/screen/product/comment/comment_list.dart';
import 'package:nike_store/widgets/widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  final ProductEntity product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}


class _ProductDetailScreenState extends State<ProductDetailScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          bloc.stream.listen((state) {
            if (state is ProductAddToCartButtonSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه گردید')));
            } else if (state is ProductAddToCartButtonError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                state.exception.message.toString(),
              )));
            }
          });
          return bloc;
        },
        child: Scaffold(
          floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(CartAddButtonClick(widget.product.id!));
                    },
                    label: state is ProductAddToCartButtonLoading
                        ? const CupertinoActivityIndicator()
                        : Text(
                            'افزودن به سبد خرید',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                  );
                },
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            physics: defualtBouncingScrollPhysics,
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width * .8,
                flexibleSpace: ImageLoadingService(
                  url: widget.product.image!,
                ),
                foregroundColor: LightThemeColors.primaryTextColor,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(CupertinoIcons.heart)),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              widget.product.title!,
                              style: Theme.of(context).textTheme.headline6,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                widget.product.previousPrice!.withPriceLabel,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                widget.product.price!.withPriceLabel,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 12,
                      ),
                      child: Text(
                        'این کفش برای پیاده روی به شدت توصیه می شود. و بسیار سبک و راحت می باشد.این کفش برای پیاده روی به شدت توصیه می شود. و بسیار سبک و راحت می باشد.این کفش برای پیاده روی به شدت توصیه می شود. و بسیار سبک و راحت می باشد.',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نظرات کاربران',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text('ثبت نظر'))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CommentList(productId: widget.product.id!),
            ],
          ),
        ),
      ),
    );
  }
}
