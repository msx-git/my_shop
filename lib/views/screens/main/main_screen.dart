import 'package:flutter/material.dart';
import 'package:my_shop/views/screens/cart/cart_screen.dart';
import 'package:my_shop/views/screens/home/home_screen.dart';
import 'package:my_shop/views/screens/orders/orders_screen.dart';
import 'package:my_shop/views/screens/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final _screens = const [
    HomeScreen(),
    CartScreen(),
    OrdersScreen(),
    SettingsScreen(),
  ];

  final appbarTitles = const [
    'Home',
    'Cart',
    'Orders',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitles[_pageIndex]),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _pageIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _pageIndex,
        onDestinationSelected: (index) => setState(() => _pageIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home, color: Colors.teal),
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
            selectedIcon: Icon(Icons.shopping_cart, color: Colors.teal),
          ),
          NavigationDestination(
            icon: Icon(Icons.verified_outlined),
            label: 'Orders',
            selectedIcon: Icon(Icons.verified_rounded, color: Colors.teal),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
            selectedIcon: Icon(Icons.settings, color: Colors.teal),
          ),
        ],
      ),
    );
  }
}
