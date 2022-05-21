import 'package:flutter/material.dart';
import 'package:nike_store/common/exceptions.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({Key? key,required this.exception,required this.onTab}) : super(key: key);
  final AppException exception;
  final GestureTapCallback onTab;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.message.toString()),
          ElevatedButton(
            onPressed: onTab,
            child: const Text('تلاش دوباره'),
          ),
        ],
      ),
    );
  }
}
