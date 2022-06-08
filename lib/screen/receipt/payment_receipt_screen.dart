import 'package:flutter/material.dart';
import 'package:nike_store/common/theme.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رسید پرداخت'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: Theme.of(context).dividerColor, width: 1),
            ),
            child: Column(
              children: [
                Text(
                  'پرداخت با موفقیت انجام شد',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'وضعیت سفارش',
                      style:
                          TextStyle(color: LightThemeColors.seconderyTextColor),
                    ),
                    const Text(
                      'پرداخت شده',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 32,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مبلغ',
                      style:
                          TextStyle(color: LightThemeColors.seconderyTextColor),
                    ),
                    const Text(
                      '14000000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('بازگشت به صفحه اصلی'),
          ),
        ],
      ),
    );
  }
}
