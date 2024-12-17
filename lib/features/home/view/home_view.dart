import 'package:eco/features/home/view/widget/home_app_bar.dart';
import 'package:eco/features/home/view/widget/home_tab_bar.dart';
import 'package:flutter/material.dart';
import 'categories_body.dart';
import 'home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String routeName = '/home_view';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int currentPageIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);

    super.initState();
  }

  List<Widget> pages = [
    const HomeBody(),
    const CategoriesBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: HomeAppBar(),
              ),
              HomeTabBar(
                tabController: _tabController,
                onTap: (value) {
                  setState(() {
                    _tabController.index = value;
                  });
                },
              ),
              Expanded(child: pages[_tabController.index])
            ],
          ),
        ),
      ),
    );
  }
}
