import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/shipping/shipping_bloc.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/models/order/order.dart';
import 'package:nike_store/screen/cart/price_info_screen.dart';
import 'package:nike_store/screen/receipt/payment_receipt_screen.dart';

class ShippingScreen extends StatefulWidget {
  ShippingScreen(
      {Key? key,
      required this.totalPrice,
      required this.payablePrice,
      required this.shippingCost})
      : super(key: key);

  final int totalPrice;
  final int payablePrice;
  final int shippingCost;

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  TextEditingController firstNameController =
      TextEditingController(text: 'حمید');

  TextEditingController lastNameController =
      TextEditingController(text: 'خوبانی');

  TextEditingController phoneNumberController =
      TextEditingController(text: '09380175936');

  TextEditingController postalCodeController =
      TextEditingController(text: '7591176795');

  TextEditingController addrssController =
      TextEditingController(text: 'یاسوج خیابان ولی عصر فرعی هفت ');

  StreamSubscription? subscription;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen((state) {
            if (state is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.exception.toString(),
                  ),
                ),
              );
            } else if (state is ShippingSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PaymentReceiptScreen(),
                ),
              );
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('نام')),
                controller: firstNameController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('نام خانوادگی')),
                controller: lastNameController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('شماره تماس')),
                controller: phoneNumberController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('کد پستی')),
                controller: postalCodeController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('آدرس')),
                controller: addrssController,
              ),
              PriceInfoScreen(
                payablePrice: widget.payablePrice,
                shippingCost: widget.shippingCost,
                totalPrice: widget.totalPrice,
              ),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                  ShippingCreateOrder(
                                    CreateOrderParams(
                                      firstNameController.text,
                                      lastNameController.text,
                                      phoneNumberController.text,
                                      postalCodeController.text,
                                      addrssController.text,
                                      PaymentMethod.cashOnDelivery,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('پرداخت در محل'),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('خرید اینترنتی'),
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
