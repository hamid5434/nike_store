import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/theme.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/models/product/product.dart';
import 'package:nike_store/widgets/widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: FloatingActionButton.extended(
                onPressed: () {}, label: const Text('افزودن به سبد خرید'))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          physics: defualtBouncingScrollPhysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * .8,
              flexibleSpace: ImageLoadingService(
                url: product.image!,
              ),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.heart)),
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
                            product.title!,
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product.previousPrice!.withPriceLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product.price!.withPriceLabel,
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
                        TextButton(onPressed: () {}, child: Text('ثبت نظر'))
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 1000,
                    color: Colors.grey,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
