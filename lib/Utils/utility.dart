import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';

class Utils{

  /// function to show SnackBar
  void showSnackBar(String message, BuildContext context,
      {Color? color,Color? textColor}) {
    final snackBar = SnackBar(
        content: Text(
          message,
          style: TextStyles.bodyText1.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold, color: textColor??AppColors.appColorWhite),
          textAlign: TextAlign.center,
        ),
        backgroundColor: color?? AppColors.appColorBlack65);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getDateFormat(String pattern, DateTime date) {
    var formatter = DateFormat(pattern);
    return formatter.format(date);
  }
}

extension OnString on String {
  // extension on String capitalize first alphabet of String
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
}