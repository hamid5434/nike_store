import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/models/cart/cart_item_entity.dart';
import 'package:nike_store/screen/cart/widget/widgtes.dart';

class CartListItems extends StatelessWidget {
  const CartListItems({Key? key, required this.cartItems}) : super(key: key);

  final CartItems cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.cartItems!.length,
      itemBuilder: (context, index) {
        final data = cartItems.cartItems![index];
        return CartItem(
          data: data,
          onDeleteButtonClick: () {

          },
        );
      },
    );
  }
}
