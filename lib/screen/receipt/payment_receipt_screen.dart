import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/receipt/payment_receipt_bloc.dart';
import 'package:nike_store/common/theme.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/order_repository.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({Key? key, required this.orderId})
      : super(key: key);
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رسید پرداخت'),
      ),
      body: BlocProvider<PaymentReceiptBloc>(
        create: (context) {
          final bloc = PaymentReceiptBloc(orderRepository)
            ..add(
              PaymentReceiptStart(orderId),
            );

          return bloc;
        },
        child: BlocBuilder<PaymentReceiptBloc, PaymentReceiptState>(
          builder: (context, state) {
            if (state is PaymentReceiptSuccess) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          state.paymentReceiptData.purchaseSuccess
                              ? 'پرداخت با موفقیت انجام شد'
                              : 'پرداخت ناموفق',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                color: state.paymentReceiptData.purchaseSuccess ?
                                Theme.of(context).colorScheme.primary :
                                LightThemeColors.seconderyTextColorError,
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
                              style: TextStyle(
                                  color: LightThemeColors.seconderyTextColor),
                            ),
                            Text(
                              state.paymentReceiptData.paymentStatus,
                              style: const TextStyle(
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
                              style: TextStyle(
                                  color: LightThemeColors.seconderyTextColor),
                            ),
                            Text(
                              state.paymentReceiptData.payablePrice
                                  .withPriceLabel,
                              style: const TextStyle(
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
              );
            } else if (state is PaymentReceiptError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is PaymentReceiptLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else {
              return const Center(
                child: Text('state is not supported!'),
              );
            }
          },
        ),
      ),
    );
  }
}
