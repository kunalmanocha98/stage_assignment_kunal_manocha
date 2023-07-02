import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_test/Components/buttons.dart';
import 'package:stage_test/Components/logo.dart';
import 'package:stage_test/Components/spacers.dart';
import 'package:stage_test/Components/text_fields.dart';
import 'package:stage_test/UI/Login/Provider/login_provider.dart';
import 'package:stage_test/Utils/Mixins/profile_mixins.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';

import '../../Components/gradients.dart';
import '../../Utils/Themes/colors.dart';
import '../../Utils/Themes/text_styles.dart';

/// This is a Login class to help user login in to the app.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with ProfileMixins {
  late LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: BoxDecoration(gradient: Gradients.backgroundGradient),
      child: SingleChildScrollView(
        child: Form(
          key: loginProvider.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacers.w50Spacer,
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.appColorWhite,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogo.appLogo,
                ],
              ),
              Spacers.w70Spacer,
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 50),
                child: Text(
                  Strings.signIn,
                  style: TextStyles.headline4.copyWith(
                      color: AppColors.appColorWhite,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFields().appTextField(
                  controller: loginProvider.emailController,
                  hint: Strings.enterEmail,
                  validator: validateEmail,
                  inputType: TextInputType.emailAddress),
              TextFields().appTextField(
                  controller: loginProvider.passController,
                  hint: Strings.enterPassword,
                  validator: validatePassword,
                  obscureText: true),
              Spacers.w50Spacer,
              Consumer<LoginProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                return loginProvider.isLoading
                    ? const CircularProgressIndicator()
                    : AppButtons(
                        onClick: () {
                          // check fields and sign in
                          loginProvider.check(context);
                        },
                        buttonTitle: Strings.signIn,
                      ).textButton;
              }),
              Separators.lineSeparatorWhiteOr,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<LoginProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return loginProvider.isGoogleLoading
                          ? CircularProgressIndicator(
                              color: AppColors.appColorRed,
                            )
                          : GoogleButton(onClick: () {
                            // Google sign in
                              loginProvider.googleSignIn(context);
                            });
                    },
                  ),
                ],
              ),
              Spacers.w50Spacer,
            ],
          ),
        ),
      ),
    ));
  }
}
