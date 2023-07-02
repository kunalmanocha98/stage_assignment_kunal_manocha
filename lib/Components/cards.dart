import 'package:flutter/cupertino.dart';
import 'package:stage_test/Components/shadows.dart';
import 'package:stage_test/Utils/Themes/colors.dart';

class CustomCard extends StatelessWidget{
  final Widget child;
  const CustomCard({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.appColorWhite,
          boxShadow: [CustomShadows.lightShadow]
      ),
      child: child,
    );
  }

}