import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';

class PriceInfoScreen extends StatelessWidget {
  const PriceInfoScreen({
    Key? key,
    required this.payablePrice,
    required this.shippingCost,
    required this.totalPrice,
  }) : super(key: key);

  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          child: Text(
            'جزییات خرید',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(.05),
                )
              ]),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ کل خرید'),
                    RichText(
                      text: TextSpan(
                          text: totalPrice.separateByComma,
                          style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          children: [
                            TextSpan(
                              text: ' تومان ',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('هزینه ارسال'),
                    Text(shippingCost.withPriceLabel),
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('مبلغ قابل پرداخت'),
                    RichText(
                      text: TextSpan(
                          text: payablePrice.separateByComma,
                          style: DefaultTextStyle.of(context).style.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          children: [
                            TextSpan(
                              text: ' تومان ',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                            ),
                          ]),
                    ),
                    //Text(payablePrice.withPriceLabel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
