import 'package:flutter/material.dart';
import 'package:stage_test/Components/gradients.dart';
import 'package:stage_test/Components/logo.dart';
import 'package:stage_test/UI/AuthPage/auth_page.dart';

/// This is the first page user sees when he/she opens the app
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Function to delay the process to go another page
      // Delay by 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const AuthPage();
        }),(_)=>false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: Gradients.backgroundGradient),
        child: Center(
          child: AppLogo.appLogo,
        ),
      ),
    );
  }
}
