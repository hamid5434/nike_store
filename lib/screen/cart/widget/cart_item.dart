import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/models/cart/cart_item_entity.dart';
import 'package:nike_store/widgets/image_loading_service.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.data,
    required this.onDeleteButtonClick,
    required this.onIncraseButtonClick,
    required this.onDecraseButtonClick,
  }) : super(key: key);

  final CartItemEntity data;
  final GestureTapCallback onDeleteButtonClick;
  final GestureTapCallback onIncraseButtonClick;
  final GestureTapCallback onDecraseButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 120,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ImageLoadingService(
                    url: data.product!.image!,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    data.product!.title!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '??????????',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onIncraseButtonClick,
                          icon: const Icon(CupertinoIcons.plus_app),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: data.changeCountLoading
                                ? const SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    data.count!.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: onDecraseButtonClick,
                          icon: const Icon(CupertinoIcons.minus_square),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.product!.previusPrice!.withPriceLabel,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Text(
                      data.product!.price!.withPriceLabel,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            width: double.infinity,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: data.deleteButtonLoading
                ? Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 6, left: 4, right: 4),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: onDeleteButtonClick,
                    child: Text(
                      '?????? ???? ?????? ????????',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorDark,
                          ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
