
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/screen/root/root_screen.dart';

import 'botton_navigation_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
    required this.onTab,
    required this.selectIndex,
  }) : super(key: key);
  final Function(int index) onTab;

  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: const Color(0x009b8487).withOpacity(.3),
                  blurRadius: 20,
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavigationItem(
                    onTab: () {
                      onTab(HOMEINDEX);
                    },
                    isActive: selectIndex == HOMEINDEX,
                    title: 'خانه',
                    icons: CupertinoIcons.home,
                  ),
                  BottomNavigationItem(
                    onTab: () {
                      onTab(CARTINDEX);
                    },
                    isActive: selectIndex == CARTINDEX,
                    title: 'سبد خرید',
                    icons: CupertinoIcons.cart,
                    isShowBadge: true,
                  ),
                  BottomNavigationItem(
                    onTab: () {
                      onTab(PROFILEINDEX);
                    },
                    title: 'پروفایل',
                    isActive: selectIndex == PROFILEINDEX,
                    icons: CupertinoIcons.profile_circled,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}