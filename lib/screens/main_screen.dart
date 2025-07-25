import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_414/screens/cart_screen.dart';
import 'package:mad_2_414/screens/favorite_screen.dart';
import 'package:mad_2_414/screens/home_screen.dart';
import 'package:mad_2_414/screens/more_screen.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;

  List<Widget> screenList = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[_currentIndex],
      bottomNavigationBar: _bottomNav,
    );
  }

  Widget get _bottomNav {
    final items = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'.tr),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'.tr),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'cart'.tr),
      BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'more'.tr),
    ];

    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.blueGrey,
      selectedItemColor: Colors.red,
      currentIndex: _currentIndex,
      items: items,
      onTap: (index) {
        print("Selected index: $index");
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
