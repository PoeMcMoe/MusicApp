import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/constants/dimens.dart';
import 'package:flutter_boilerplate/constants/strings.dart';

import '../../constants/app_colors.dart';

class UtilWidgets {
  UtilWidgets._();

  static Widget buildListTileTrailingLoading() => const SizedBox(
        height: 20,
        width: 20,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  static Widget buildLoading({
    double strokeWidth = 4.0,
    Color color = AppColors.primary,
  }) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              strokeWidth: strokeWidth,
              color: color,
            )
          : const CupertinoActivityIndicator(animating: true),
    );
  }

  static Widget buildSliverLoading() => SliverToBoxAdapter(
        child: buildLoading(),
      );

  static Widget buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: buildLoading(),
    );
  }

  static Widget buildNoContentText({String text = Strings.defaultNoContent}) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.blockContentPadding),
      child: Text(
        text,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }
}
