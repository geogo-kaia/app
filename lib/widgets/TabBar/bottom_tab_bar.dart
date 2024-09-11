import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  final int index;
  final void Function(int index) action;
  const BottomTabBar(this.index, this.action, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Color(0xFFB6B6B6),
      selectedItemColor: const Color(0xFFFFD43E),
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: (index) => action(index),
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_outlined)),
        BottomNavigationBarItem(
            label: 'Favourite', icon: Icon(Icons.bookmark_outline)),
        BottomNavigationBarItem(
            label: 'News', icon: Icon(Icons.newspaper_outlined)),
        BottomNavigationBarItem(
            label: 'Account', icon: Icon(Icons.account_circle)),
      ],
    );
  }
}
