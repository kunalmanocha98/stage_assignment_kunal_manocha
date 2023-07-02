import 'package:flutter/material.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';

import '../Utils/Themes/colors.dart';

class Spacers {
  static Widget get w08Spacer => const SizedBox(
        height: 8,
      );

  static Widget get w16Spacer => const SizedBox(
        height: 16,
      );

  static Widget get w20Spacer => const SizedBox(
        height: 20,
      );

  static Widget get w32Spacer => const SizedBox(
        height: 32,
      );

  static Widget get w50Spacer => const SizedBox(
        height: 50,
      );

  static Widget get w70Spacer => const SizedBox(
        height: 70,
      );

  static Widget get w100Spacer => const SizedBox(
        height: 100,
      );

  static Widget get w120Spacer => const SizedBox(
        height: 120,
      );

  static Widget get w150Spacer => const SizedBox(
        height: 100,
      );
}

class Separators {
  static Widget get lineSeparator => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Divider(
          color: AppColors.appColorBlack65,
          indent: 12,
          endIndent: 12,
          thickness: 1,
        ),
      );

  static Widget get lineSeparatorWhite => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Divider(
          color: AppColors.appColorWhite,
          indent: 12,
          endIndent: 12,
          thickness: 0.5,
        ),
      );

  static Widget get lineSeparatorWhiteOr => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(child: lineSeparatorWhite),
            SizedBox(
                width: 50,
                child: Center(
                    child: Text(
                  "Or",
                  textAlign: TextAlign.center,
                  style: TextStyles.caption
                      .copyWith(color: AppColors.appColorWhite),
                ))),
            Expanded(child: lineSeparatorWhite),
          ],
        ),
      );
}
