import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class Decorations {
  Decorations._();

  static const BoxDecoration bottomNavBar = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.bottomNavBarShadow,
        blurRadius: 17,
        offset: Offset(0, 0),
      ),
    ],
  );

  static const List<BoxShadow> shadow = [
    BoxShadow(
      color: AppColors.cardShadow,
      blurRadius: 20,
      offset: Offset(0, 5),
    ),
  ];
}
