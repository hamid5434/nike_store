import 'package:flutter/material.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/widgets/badge.dart';

class BottomNavigationItem extends StatelessWidget {
  final IconData icons;
  final String title;
  final bool isActive;
  final bool isShowBadge;
  final Function() onTab;

  const BottomNavigationItem({
    Key? key,
    required this.icons,
    required this.title,
    required this.isActive,
    required this.onTab,
    this.isShowBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTab,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 35,
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      icons,
                      color: isActive
                          ? Colors.blue.shade700
                          : Colors.grey.shade600,
                    ),
                  ),
                  isShowBadge
                      ? ValueListenableBuilder<int>(
                          valueListenable: CartRepository.cartItemCountNotifier,
                          builder: (context, value, child) {
                            return Badge(value: value);
                          },
                        )
                      : Container()
                ],
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color:
                      isActive ? Colors.blue.shade700 : Colors.grey.shade700),
            )
          ],
        ),
      ),
    );
  }
}
