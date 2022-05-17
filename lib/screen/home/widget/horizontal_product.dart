import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/models/product/product.dart';

class HorizontalProduct extends StatelessWidget {
  final String title;
  final GestureDragCancelCallback onTab;
  final List<ProductEntity> products;

  HorizontalProduct({
    Key? key,
    required this.title,
    required this.onTab,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(onPressed: onTab, child: const Text('مشاهده همه'))
            ],
          ),
        ),
        SizedBox(
          height: 294,
          child: ListView.builder(
            physics: defualtBouncingScrollPhysics,
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //color: Colors.deepOrange.withOpacity(.2),
                        color: Colors.white,
                      boxShadow: kElevationToShadow[4]
                    ),
                    width: 176,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 176,
                              height: 189,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: products[index].image!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                                products[index].title!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                products[index].previousPrice!.withPriceLabel,
                                style:
                                    Theme.of(context).textTheme.caption!.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                      color: Theme.of(context).colorScheme.secondary,
                                        ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                products[index].price!.withPriceLabel,
                                style:
                                Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                            Container(),
                          ],
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(5),
                            //color: Colors.pink,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white.withOpacity(.8),
                            ),
                            child: const Center(
                              child: Icon(CupertinoIcons.heart, size: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
