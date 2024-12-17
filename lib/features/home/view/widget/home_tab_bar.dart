import 'package:flutter/material.dart';
import 'package:eco/utils/box_styles.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
    required this.tabController,
    required this.onTap,
  });

  final TabController tabController;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      dividerColor: Colors.transparent,
      onTap: onTap,
      tabs: const [
        Tab(
          child: Text(
            'Home',
            style: StylesBox.bold16,
          ),
        ),
        Tab(
          child: Text(
            'Categories',
            style: StylesBox.bold16,
          ),
        ),
      ],
    );
  }
}
