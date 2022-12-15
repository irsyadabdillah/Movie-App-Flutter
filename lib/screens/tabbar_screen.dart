// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_app_flutter/screens/home_screen.dart';
import 'package:movie_app_flutter/screens/search_screen.dart';
import 'package:movie_app_flutter/screens/setting_screen.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:movie_app_flutter/widgets/tabbar_item.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({Key? key}) : super(key: key);

  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen>
    with TickerProviderStateMixin {
  int activeTabIndex = 1;
  List barItems = [
    {
      "icon": "assets/icons/search.svg",
      "page": SearchScreen(),
    },
    {
      "icon": "assets/icons/home.svg",
      "page": HomeScreen(),
    },
    {
      "icon": "assets/icons/setting.svg",
      "page": SettingScreen(),
    },
  ];

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    if (index == activeTabIndex) return;
    _controller.reset();
    setState(() {
      activeTabIndex = index;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: buildBottomBar(),
      body: buildBottomBarPage(),
    );
  }

  Widget buildBottomBarPage() {
    return IndexedStack(
      index: activeTabIndex,
      children: List.generate(
          barItems.length, (index) => animatedPage(barItems[index]["page"])),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: black87.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 45,
          right: 45,
          bottom: 15,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                barItems.length,
                (index) => TabbarItem(
                      barItems[index]["icon"],
                      isActive: activeTabIndex == index,
                      activeColor: maroon,
                      onTap: () {
                        onPageChanged(index);
                      },
                    ))),
      ),
    );
  }
}
