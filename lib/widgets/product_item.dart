import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/source/favorite_manager.dart';
import 'package:nike_store/models/product/product.dart';
import 'package:nike_store/screen/product/product_detail_screen.dart';

class ProductItem extends StatefulWidget {
  ProductItem({
    Key? key,
    required this.product,
    required this.borderRadius,
    this.itemWidth = 176,
    this.itemheight = 189,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;

  final double itemWidth;
  final double itemheight;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  ValueNotifier? isFavorite;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFavorite = ValueNotifier(favoriteManager.isFavorite(widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                product: widget.product,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: Colors.grey.withOpacity(.3),
                width: .2,
              )
              //color: Colors.deepOrange.withOpacity(.2),
              //color: Colors.white,
              //boxShadow: kElevationToShadow[4]
              ),
          width: widget.itemWidth,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AspectRatio(
                    aspectRatio: .93,
                    child: ClipRRect(
                      borderRadius: widget.borderRadius,
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.product.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.product.previousPrice!.withPriceLabel,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.product.price!.withPriceLabel,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Container(),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: InkWell(
                  onTap: () {
                    print(isFavorite!.value);
                    if (favoriteManager.isFavorite(widget.product)) {
                      favoriteManager.delete(widget.product);
                      isFavorite!.value = false;
                    } else {
                      favoriteManager.addFavorite(widget.product);
                      isFavorite!.value = true;
                    }
                    print(isFavorite!.value);

                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(5),
                    //color: Colors.pink,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(.8),
                    ),
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: isFavorite!,
                        builder: (context, value, child) {
                          return Icon(
                              isFavorite!.value
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              size: 25);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
