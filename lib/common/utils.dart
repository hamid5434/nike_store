import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const defualtBouncingScrollPhysics = BouncingScrollPhysics();

extension PriceLabel on int {
  String get withPriceLabel => this > 0 ? '$separateByComma تومان ' : 'رایگان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
