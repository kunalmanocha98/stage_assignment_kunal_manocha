import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stage_test/Models/Collections/user_collection.dart';
import 'package:stage_test/UI/AuthPage/auth_page.dart';
import 'package:stage_test/UI/Login/login_page.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Strings/collection_constants.dart';
import 'package:stage_test/Utils/utility.dart';

/// This class serves as a provider to Sign up page
class SignupProvider extends ChangeNotifier {
  // Google Sign in variable
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // Text editing controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  // Form key to be used for validation
  GlobalKey<FormState> formKey = GlobalKey();
  // Loading state holders
  bool isLoading = false;
  bool isGoogleLoading = false;

  /// function to check text fields with validators
  void check(BuildContext context) {
    startLoading();
    if (formKey.currentState!.validate()) {
      // validation successful
      checkEmail(context);
    }else{
      // validation failed
      stopLoading();
    }
  }

  /// function to change loading state of login button
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  /// function to change loading state of Google Sign in button
  void startLoadingGoogle() {
    isGoogleLoading = true;
    notifyListeners();
  }

  /// function to change loading state of buttons
  void stopLoading() {
    isLoading = false;
    isGoogleLoading = false;
    notifyListeners();
  }

  /// function to check if email is registered or not
  void checkEmail(BuildContext context) {
    FirebaseFirestore.instance
        .collection(Collections.user)
        .where(UserConstants.email, isEqualTo: emailController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        // User is not registered
        submit(context);
      } else {
        // User is already registered
        stopLoading();
        Utils().showSnackBar(Strings.emailAlreadyExist, context);
      }
    });
  }

  /// function to log in with credentials
  void submit(BuildContext context) {
    clear();
    FirebaseFirestore.instance
        .collection(Collections.user)
        .add(UserCollection(email: emailController.text, name: nameController.text).toJson())
        .then((value) {
          // User registration successful
      stopLoading();
      Utils().showSnackBar(Strings.userAddedSuccessfully, context);
      // navigate to login page
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const LoginPage();
      }));
    }).catchError((onError) {
      // User registration failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to sign in via Google Sign in
  void googleSignIn(BuildContext context) {
    startLoadingGoogle();
    clear();
    _googleSignIn.signIn().then((google) {
      // Sign in success
     retrieveCredential(context,google);
    }).catchError((onError){
      // Sign in failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to retrieve credentials from google sign in
  void retrieveCredential(BuildContext context, GoogleSignInAccount? google){
    google!.authentication.then((value) {
      // Credentials retrieval success
      var credential = GoogleAuthProvider.credential(idToken: value.idToken, accessToken: value.accessToken);
      signInWithCredential(context,credential);
    }).catchError((onError){
      // Credentials retrieval failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to sign in with credentials
  void signInWithCredential(BuildContext context,OAuthCredential credential){
    FirebaseAuth.instance.signInWithCredential(credential).then((authCred) {
      FirebaseFirestore.instance.collection(Collections.user).where(UserConstants.email,isEqualTo: authCred.user?.email).get().then((value) {
        if(value.docs.isEmpty){
          // User does not exists
          FirebaseFirestore.instance
              .collection(Collections.user)
              .add(UserCollection(email: authCred.user!.email, name: authCred.user!.displayName).toJson())
              .then((value) {
                navigateToHomePage(context);
          });
        }else{
          // User exists
          navigateToHomePage(context);
        }
      }).catchError((onError){
        // User fetch failed
        stopLoading();
        Utils().showSnackBar(Strings.someErrorOccurred, context);
      });
    }).catchError((onError){
      // Sign in with Google failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to navigate back to the auth page so that it can navigate accordingly
  void navigateToHomePage(BuildContext context){
    Utils().showSnackBar(Strings.loggedInSuccessfully, context);
    stopLoading();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return const AuthPage();
    }), (route) => false);
  }

  /// function to clear fields
  void clear(){
    nameController.clear();
    emailController.clear();
    passController.clear();
    notifyListeners();
  }

}
