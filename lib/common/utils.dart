import 'package:flutter/cupertino.dart';

const defualtBouncingScrollPhysics = BouncingScrollPhysics();

extension PriceLabel on int {
  String get withPriceLabel => '$this تومان';
}