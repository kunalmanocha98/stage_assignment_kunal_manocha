import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_test/UI/CreatePage/Provider/create_provider.dart';
import 'package:stage_test/UI/HomePage/Provider/home_page_provider.dart';
import 'package:stage_test/UI/Login/Provider/login_provider.dart';
import 'package:stage_test/UI/Signup/Provider/signup_provider.dart';
import 'package:stage_test/UI/Splash/splash.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => CreateTaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => SignupProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => LoginProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.appColorWhite,
            centerTitle: true,
            elevation: 0,
            titleTextStyle:
                TextStyles.headline6.copyWith(fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: AppColors.appColorBlack85),
          ),
          dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: AppColors.primaryColor,
              onPrimary: AppColors.appColorWhite,
              secondary: AppColors.primaryColor,
              onSecondary: AppColors.appColorWhite,
              error: AppColors.appColorRed,
              onError: AppColors.appColorWhite,
              background: AppColors.appColorBackground,
              onBackground: AppColors.appColorWhite,
              surface: AppColors.appColorWhite,
              onSurface: AppColors.appColorBlack85),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
