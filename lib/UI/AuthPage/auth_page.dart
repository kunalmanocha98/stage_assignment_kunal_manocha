import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_test/UI/HomePage/home_page.dart';
import 'package:stage_test/UI/Landing/landing_page.dart';


/// This class is used to listen authState changes
class AuthPage extends StatelessWidget{
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            // When user is logged in
            return const HomePage();
          }else{
            // When user got logged out
            return const LandingPage();
          }
        },
      ),
    );
  }

}