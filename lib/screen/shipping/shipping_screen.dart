import 'package:flutter/material.dart';
import 'package:nike_store/screen/cart/price_info_screen.dart';
import 'package:nike_store/screen/receipt/payment_receipt_screen.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen(
      {Key? key,
      required this.totalPrice,
      required this.payablePrice,
      required this.shippingCost})
      : super(key: key);

  final int totalPrice;
  final int payablePrice;
  final int shippingCost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const TextField(
              decoration: InputDecoration(label: Text('نام و نام خانوادگی')),
            ),
            const SizedBox(
              height: 8,
            ),
            const TextField(
              decoration: InputDecoration(label: Text('شماره تماس')),
            ),
            const SizedBox(
              height: 8,
            ),
            const TextField(
              decoration: InputDecoration(label: Text('کد پستی')),
            ),
            const SizedBox(
              height: 8,
            ),
            const TextField(
              decoration: InputDecoration(label: Text('آدرس')),
            ),
            PriceInfoScreen(
              payablePrice: payablePrice,
              shippingCost: shippingCost,
              totalPrice: totalPrice,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PaymentReceiptScreen(),
                        ),
                      );
                    },
                    child: const Text('پرداخت در محل')),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('خرید اینترنتی')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
