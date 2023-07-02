import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';
typedef AppValidator = String? Function(String?)?;
class TextFields {
  Widget appTextField({
    Key? key,
    String? hint,
    TextEditingController? controller,
    AppValidator validator,
    TextInputType? inputType,
    bool obscureText = false
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.appColorWhite,
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        style: TextStyles.subtitle1,
        controller: controller,
        validator: validator,
        keyboardType: inputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint ?? 'Please write here',
          hintStyle: TextStyles.bodyText1,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          // suffixIcon: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(
          //     Icons.check_circle,
          //     color: AppColors.gradient3,
          //   ),
          // ),
        ),
      ),
    );
  }
}
