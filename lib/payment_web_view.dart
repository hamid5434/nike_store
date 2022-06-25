import 'package:flutter/material.dart';
import 'package:nike_store/screen/receipt/payment_receipt_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGetwayScreen extends StatelessWidget {
  const PaymentGetwayScreen({
    Key? key,
    required this.bankGetewayurl,
  }) : super(key: key);

  final String bankGetewayurl;

  @override
  Widget build(BuildContext context) {
    print(bankGetewayurl);
    return WebView(
      initialUrl: bankGetewayurl,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) {
        print(url);
        final uri = Uri.parse(url);

        if (uri.pathSegments.contains('checkout') &&
            uri.host == 'expertdevelopers.ir') {
          final orderId = int.parse(uri.queryParameters['order_id']!);
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentReceiptScreen(
                orderId: orderId,
              ),
            ),
          );
        }
      },
    );
  }
}
