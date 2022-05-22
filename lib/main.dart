import 'package:flutter/material.dart';
import 'package:nike_store/common/theme.dart';
import 'package:nike_store/data/repo/baner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/screen/auth/auth_screen.dart';
import 'package:nike_store/screen/home/home.dart';
import 'package:nike_store/screen/root/root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.seconderyColor,
          onSecondary: Colors.white,
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            fontFamily: 'iransans',
            color: LightThemeColors.seconderyTextColor,
          ),
          button: const TextStyle(
            fontFamily: 'iransans',
          ),
          bodyText2: const TextStyle(
            fontFamily: 'iransans',
          ),
          headline6: const TextStyle(
            fontFamily: 'iransans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          caption: const TextStyle(
            fontFamily: 'iransans',
          ).apply(
            color: LightThemeColors.seconderyTextColor,
          ),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: AuthScreen(),
      ),
    );
  }
}

// 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
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bannerRepository.getAll().then((value) {
      print(value[0].image.toString());
    }).catchError((onError) {
      print(onError.toString());
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('فروشگاه نایک'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('حمیدرضا'),
      ),
    );
  }
}
