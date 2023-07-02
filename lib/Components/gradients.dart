import 'package:flutter/cupertino.dart';
import 'package:stage_test/Utils/Themes/colors.dart';

class Gradients {
  static LinearGradient get backgroundGradient => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
            AppColors.gradient3,
          ]);
}
