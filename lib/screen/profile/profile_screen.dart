import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/theme.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پروفایل'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              CartRepository.cartItemCountNotifier.value = 0;
              authRepository.signOut();
            },
            child: Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: LightThemeColors.primaryColorError,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'خروچ از حساب',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: LightThemeColors.primaryColorError,
                      ),
                )
              ],
            ),
          ),
        ],
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
            const Text('h_khobani@yahoo.com'),
            const SizedBox(
              height: 32,
            ),
            const Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {},
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
              onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
