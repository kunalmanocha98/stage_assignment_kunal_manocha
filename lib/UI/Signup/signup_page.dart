import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_test/Components/buttons.dart';
import 'package:stage_test/Components/logo.dart';
import 'package:stage_test/Components/spacers.dart';
import 'package:stage_test/Components/text_fields.dart';
import 'package:stage_test/UI/Signup/Provider/signup_provider.dart';
import 'package:stage_test/Utils/Mixins/general_mixin.dart';
import 'package:stage_test/Utils/Mixins/profile_mixins.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Themes/colors.dart';
import '../../Components/gradients.dart';
import '../../Utils/Themes/text_styles.dart';

/// This class is used to create Sign up page
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<SignUpPage> with ProfileMixins, GeneralMixins {
  // Provider variable
  late SignupProvider signupProvider;

  @override
  Widget build(BuildContext context) {
    //provider initialisation
    signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: Gradients.backgroundGradient),
        child: SingleChildScrollView(
          child: Form(
            key: signupProvider.formKey,
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
                    Strings.signUp,
                    style: TextStyles.headline4.copyWith(
                        color: AppColors.appColorWhite,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextFields().appTextField(
                    controller: signupProvider.nameController,
                    hint: Strings.enterName,
                    validator: validateField),
                TextFields().appTextField(
                    controller: signupProvider.emailController,
                    hint: Strings.enterEmail,
                    inputType: TextInputType.emailAddress,
                    validator: validateEmail),
                TextFields().appTextField(
                    controller: signupProvider.passController,
                    obscureText: true,
                    hint: Strings.enterPassword,
                    validator: validatePassword),
                Spacers.w50Spacer,
                Consumer<SignupProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      // Change the state of the button when the process is running
                  return signupProvider.isLoading
                      ? const CircularProgressIndicator()
                      : AppButtons(
                          onClick: () {
                            // check and register user
                            signupProvider.check(context);
                          },
                          buttonTitle: Strings.createAccount,
                        ).textButton;
                }),
                Separators.lineSeparatorWhiteOr,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<SignupProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        // Change the state of the button when the process is running
                        return signupProvider.isGoogleLoading
                            ? CircularProgressIndicator(
                                color: AppColors.appColorRed,
                              )
                            : GoogleButton(onClick: () {
                              // register and login with Google
                                signupProvider.googleSignIn(context);
                              });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
