import 'package:flutter/material.dart';
import 'package:stage_test/Components/buttons.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';

class CustomConfirmDialog extends StatelessWidget {
  final void Function() okCallback;
  final void Function() cancelCallback;
  final String message;

  const CustomConfirmDialog(
      {super.key,
      required this.okCallback,
      required this.cancelCallback,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              Strings.confirm,
              style: TextStyles.headline6.copyWith(
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: Text(
              message,
              style: TextStyles.subtitle1,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              AppButtons(onClick: cancelCallback, buttonTitle: Strings.cancel)
                  .textButtonSmall,
              AppButtons(onClick: okCallback, buttonTitle: Strings.ok)
                  .textButtonSmall
            ],
          )
        ],
      ),
    );
  }
}
