import 'package:flutter/material.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            await authRepository.signOut();
            CartRepository.cartItemCountNotifier.value = 0;
          },
          child: const Text(
            'خروج از حساب',
          ),
        ),
      ],
    );
  }
}
