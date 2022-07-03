import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/theme.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/screen/auth/auth_screen.dart';
import 'package:nike_store/screen/favorit/favorit_screen.dart';
import 'package:nike_store/screen/order/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        centerTitle: true,
        actions: [],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 32, bottom: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Image.asset(
                'assets/images/nike_logo.png',
              ),
            ),
            ValueListenableBuilder(
              valueListenable: AuthRepository.authChangeNotifier,
              builder: (context, value, child) {
                return Text(value != null
                    ? AuthRepository.authChangeNotifier.value!.email!
                    : '');
              },
            ),
            const SizedBox(
              height: 32,
            ),
            const Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoritScreen(),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                height: 56,
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.heart),
                    SizedBox(
                      width: 16,
                    ),
                    Text('لیست علاقمندی ها')
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryScreen(),
                  ),
                );
              },
              child: Container(
                height: 56,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.cart),
                    SizedBox(
                      width: 16,
                    ),
                    Text('سوابق سفارش')
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            ValueListenableBuilder(
              valueListenable: AuthRepository.authChangeNotifier,
              builder: (context, value, child) {
                return AuthRepository.authChangeNotifier.value != null
                    ? InkWell(
                        onTap: () {
                          dialog(context);
                        },
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: const [
                              Icon(CupertinoIcons.square_arrow_right),
                              SizedBox(
                                width: 16,
                              ),
                              Text('خروج از حساب کاربری')
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: const [
                              Icon(CupertinoIcons.square_arrow_left),
                              SizedBox(
                                width: 16,
                              ),
                              Text('ورود به حساب کاربری')
                            ],
                          ),
                        ),
                      );
              },
            ),
            const Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  void dialog(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              "خروج از حساب",
              style: Theme.of(context).textTheme.caption,
            ),
            content: const Text("آیا میخواهید از حساب خود خارج شوید؟"),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('برگشت'),
              ),
              ElevatedButton(
                onPressed: () {
                  CartRepository.cartItemCountNotifier.value = 0;
                  authRepository.signOut();
                  Navigator.of(context).pop();
                },
                child: const Text('خروج'),
              ),
            ],
          ),
        );
      },
    );
  }
}
