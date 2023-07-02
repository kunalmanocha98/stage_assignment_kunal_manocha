import 'package:flutter/material.dart';

class AppLogo{
  static Widget get appLogo => Image.asset('assets/images/app_icon.png',
    height:120,
    width: 120,
    fit: BoxFit.contain,
  );
}