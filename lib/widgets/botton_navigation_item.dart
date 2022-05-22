
import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final IconData icons;
  final String title;
  final bool isActive;
  final Function() onTab;

  const BottomNavigationItem(
      {Key? key,
        required this.icons,
        required this.title,
        required this.isActive,
        required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTab,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icons,
              color: isActive ? Colors.blue.shade700 : Colors.grey.shade600,
            ),
            const SizedBox(
              height: 4,
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