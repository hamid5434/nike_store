import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike_store/common/theme.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/source/favorite_manager.dart';
import 'package:nike_store/models/product/product.dart';
import 'package:nike_store/screen/product/product_detail_screen.dart';
import 'package:nike_store/widgets/image_loading_service.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست علاقمندی ها'),
      ),
      body: ValueListenableBuilder<Box<ProductEntity>>(
        valueListenable: favoriteManager.listenable,
        builder: (context, box, child) {
          final products = box.values.toList();
          return ListView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemBuilder: (context, index) {
              final product = products[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                },
                onLongPress: () {
                  favoriteManager.delete(product);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        height: 110,
                        child: ImageLoadingService(
                          url: product.image!,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: LightThemeColors.primaryTextColor,
                                  ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              product.previousPrice!.withPriceLabel,
                              style: Theme.of(context).textTheme.caption!.apply(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            Text(product.price!.withPriceLabel),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
