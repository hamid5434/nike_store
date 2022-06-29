import 'package:flutter/material.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لیست علاقمندی ها'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
        return Container();
      },),
    );
  }
}
