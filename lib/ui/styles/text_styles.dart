import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/dimens.dart';
import '../../constants/font_family.dart';

class TextStyles {
  TextStyles._();

  static const bottomNavBarSelected = TextStyle(
    fontFamily: FontFamily.oswald,
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );

  static const bottomNavBarUnselected = TextStyle(
    fontFamily: FontFamily.oswald,
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );

  static const startHeader = TextStyle(
    fontFamily: FontFamily.oswald,
    fontWeight: FontWeight.w300,
    fontSize: 16,
    color: AppColors.grey,
  );

  static const header = TextStyle(
    fontFamily: FontFamily.oswald,
    fontWeight: FontWeight.w600,
    fontSize: 28,
    color: AppColors.black,
  );

  static const subHeader = TextStyle(
    fontFamily: FontFamily.oswald,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.grey,
  );

  static const boldSubHeader = TextStyle(
    fontFamily: FontFamily.oswald,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.black,
  );

  static const whiteTextButtonTextStyle = TextStyle(
    color: AppColors.textAlternativeColor,
    fontSize: Dimens.default_button_font_size,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.poppins,
    letterSpacing: 1.1,
  );

  static const accentTextButtonTextStyle = TextStyle(
    color: AppColors.accent,
    fontSize: Dimens.default_button_font_size,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.poppins,
  );

  static const screenTitleTextStyle = TextStyle(
    color: AppColors.textMainColor,
    fontSize: Dimens.default_title_font_size,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.poppins,
  );


}
