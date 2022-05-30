import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(
      {Key? key, required this.message, this.image, this.callToAction})
      : super(key: key);
  final String message;
  final Widget? image;
  final Widget? callToAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image ?? Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          callToAction ?? Container(),
        ],
      ),
    );
  }
}
