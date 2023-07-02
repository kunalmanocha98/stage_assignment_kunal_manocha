import 'package:flutter/material.dart';
import 'package:stage_test/Components/buttons.dart';
import 'package:stage_test/Components/gradients.dart';
import 'package:stage_test/Components/logo.dart';
import 'package:stage_test/Components/spacers.dart';
import 'package:stage_test/UI/Login/login_page.dart';
import 'package:stage_test/UI/Signup/signup_page.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import 'package:stage_test/Utils/Themes/text_styles.dart';

/// This is a landing page to give user a choice to select either login or signup method
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: Gradients.backgroundGradient),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacers.w100Spacer,
              SizedBox(
                width: double.infinity,
                child: Center(child: AppLogo.appLogo),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  Strings.welcome,
                  style: TextStyles.headline4.copyWith(
                      color: AppColors.appColorWhite,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacers.w08Spacer,
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(Strings.manageTasks,
                    style: TextStyles.headline6.copyWith(
                        color: AppColors.appColorWhite,
                        fontWeight: FontWeight.normal)),
              ),
              Spacers.w32Spacer,
              AppButtons(
                onClick: () {
                  // Navigate to Log in Page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginPage();
                  }));
                },
                buttonTitle: Strings.login,
              ).textButton,
              Spacers.w16Spacer,
              AppButtons(
                onClick: () {
                  // Navigate to Sign up Page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const SignUpPage();
                  }));
                },
                buttonTitle: Strings.register,
              ).outlineButton,
              Spacers.w100Spacer
            ],
          ),
        ),
      ),
    );
  }
}
