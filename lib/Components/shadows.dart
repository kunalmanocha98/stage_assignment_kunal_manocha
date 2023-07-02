import 'package:flutter/cupertino.dart';
import 'package:stage_test/Utils/Themes/colors.dart';

class CustomShadows {
  static BoxShadow get lightShadow => BoxShadow(
    color: AppColors.appColorBlack10,
    offset: const Offset(3,3),
    blurRadius: 6
  );
}