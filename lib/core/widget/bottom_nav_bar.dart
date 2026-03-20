import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:optizenqor/core/constant/app_color.dart';
import 'package:optizenqor/feature/master/navigation/navigation_model/navigation_item_model.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final List<NavigationItemModel> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return CircleNavBar(
      activeIndex: currentIndex,
      color: AppColor.primary,
      height: 60,
      circleWidth: 60,
      circleColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 6,
      padding: EdgeInsets.zero,
      cornerRadius: const BorderRadius.only(
        topLeft: Radius.circular(0),
        topRight: Radius.circular(0),
      ),
      activeIcons: items
          .map(
            (NavigationItemModel item) =>
                Icon(item.icon, size: 30, color: AppColor.primary),
          )
          .toList(),
      inactiveIcons: items
          .map(
            (NavigationItemModel item) => const IconTheme(
              data: IconThemeData(size: 30, color: Colors.white),
              child: SizedBox.shrink(),
            ),
          )
          .toList()
          .asMap()
          .entries
          .map(
            (MapEntry<int, Widget> entry) =>
                Icon(items[entry.key].icon, size: 30, color: Colors.white),
          )
          .toList(),
      onTap: onTap,
    );
  }
}
