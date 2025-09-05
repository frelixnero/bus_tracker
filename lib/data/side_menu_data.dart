import 'package:bus_tracker/models/menu_model..dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = <MenuModel>[
    MenuModel(icon: Icons.map, title: 'Map'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.shopping_cart, title: 'Cart'),
    MenuModel(icon: Icons.person, title: 'Profile'),
  ];
}
