import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/models/product/product.dart';
import 'package:nike_store/widgets/widgets.dart';

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
          height: 296,
          child: ListView.builder(
            physics: defualtBouncingScrollPhysics,
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductItem(
                product: products[index],
                borderRadius: BorderRadius.circular(15),
              );
            },
          ),
        )
      ],
    );
  }
}
