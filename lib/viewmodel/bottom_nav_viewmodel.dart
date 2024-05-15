import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machn_tst/models/nav_item.dart';

class BottomNavViewModel extends ChangeNotifier {
  int currentIndex = 0;
  final List<NavItem> items = [
    NavItem(title: 'Home', icon: Icons.home_rounded),
    NavItem(title: 'Product', icon: Icons.list_alt_rounded),
    NavItem(title: 'Customer', icon: Icons.person_2_rounded),
  ];

  void updateIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
