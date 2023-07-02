import 'package:flutter/material.dart';
import 'package:stage_test/Utils/Themes/colors.dart';

import '../Utils/Themes/text_styles.dart';

class AppButtons {
  void Function() onClick;
  String buttonTitle;
  Color? textColor;
  Color? bgColor;

  AppButtons({required this.onClick, required this.buttonTitle,this.bgColor,this.textColor});


  Widget get textButtonSmall => Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          backgroundColor: bgColor??AppColors.appColorWhite),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0,right: 16),
        child: Text(
          buttonTitle,
          style: TextStyles.subtitle1.copyWith(color: textColor??AppColors.gradient3,fontWeight: FontWeight.w700),
        ),
      ),
    ),
  );

  Widget get textButton => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: TextButton(
          onPressed: onClick,
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: bgColor??AppColors.appColorWhite),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              buttonTitle,
              style: TextStyles.subtitle1.copyWith(color: textColor??AppColors.gradient3,fontWeight: FontWeight.w700),
            ),
          ),
        ),
      );

  Widget get outlineButton => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: TextButton(
          onPressed: onClick,
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                      width: 1,
                      color: AppColors.appColorWhite,
                      style: BorderStyle.solid))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              buttonTitle,
              style:
                  TextStyles.subtitle1.copyWith(color: AppColors.appColorWhite),
            ),
          ),
        ),
      );
}

class GoogleButton extends StatelessWidget {
  final void Function() onClick;
  final double height;
  final double width;

  const GoogleButton(
      {super.key, required this.onClick, this.height = 72, this.width = 72});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.appColorWhite,
            borderRadius: BorderRadius.circular(12),),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/google.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
