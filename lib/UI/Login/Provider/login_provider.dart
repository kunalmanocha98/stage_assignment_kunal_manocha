import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stage_test/Models/Collections/user_collection.dart';
import 'package:stage_test/UI/AuthPage/auth_page.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Strings/collection_constants.dart';
import 'package:stage_test/Utils/utility.dart';

/// This is a provider class to Login Page
class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  /// loading state handlers
  bool isLoading = false;
  bool isGoogleLoading = false;

  /// Google Sign in instance
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Text Editing Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  /// function to validate text fields
  void check(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Text fields are validated
      checkEmail(context);
    }
  }

  /// function that changes the state to loading
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  /// function that changes the state to google loading
  void startLoadingGoogle() {
    isGoogleLoading = true;
    notifyListeners();
  }

  /// function that changes the state to not loading
  void stopLoading() {
    isLoading = false;
    isGoogleLoading = false;
    notifyListeners();
  }

  /// function to check if the user is registered or not
  void checkEmail(BuildContext context) {
    startLoading();
    FirebaseFirestore.instance
        .collection(Collections.user)
        .where(UserConstants.email, isEqualTo: emailController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        // User is not registered
        stopLoading();
        Utils().showSnackBar(Strings.emailDoNotExist, context);
      } else {
        // User is registered
        submit(context);
      }
    });
  }

  /// function to initiate sign in method
  void submit(BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: emailController.text, password: passController.text)
        .then((value) {
          // Login is successful
      stopLoading();
      Utils().showSnackBar(Strings.loggedInSuccessfully, context);
    }).catchError((onError) {
      // Login failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to sign in by google
  void googleSignIn(BuildContext context) {
    startLoadingGoogle();
    _googleSignIn.signIn().then((google) {
      // Sign in successful
      retrieveCredential(context, google);
    }).catchError((onError) {
      // Sign in failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to retrieve credentials from google sign in
  void retrieveCredential(BuildContext context, GoogleSignInAccount? google) {
    google!.authentication.then((value) {
      //retrieval successful
      var credential = GoogleAuthProvider.credential(
          idToken: value.idToken, accessToken: value.accessToken);
      signInWithCredential(context, credential);
    }).catchError((onError) {
      // retrieval failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to sign in with credentials
  void signInWithCredential(BuildContext context, OAuthCredential credential) {
    FirebaseAuth.instance.signInWithCredential(credential).then((authCred) {
      FirebaseFirestore.instance
          .collection(Collections.user)
          .where(UserConstants.email, isEqualTo: authCred.user?.email)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          // User does not exist
          FirebaseFirestore.instance
              .collection(Collections.user)
              .add(UserCollection(
                      email: authCred.user!.email,
                      name: authCred.user!.displayName)
                  .toJson())
              .then((value) {
            // User entry success
            navigateToHomePage(context);
          });
        } else {
          // User already exist
          navigateToHomePage(context);
        }
      }).catchError((onError) {
        // User get failed
        stopLoading();
        Utils().showSnackBar(Strings.someErrorOccurred, context);
      });
    }).catchError((onError) {
      // Sign in failed
      stopLoading();
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to navigate back to the auth page so that it can navigate accordingly
  void navigateToHomePage(BuildContext context) {
    Utils().showSnackBar(Strings.loggedInSuccessfully, context);
    // Stop all the loaders
    stopLoading();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return const AuthPage();
    }), (route) => false);
  }
}
