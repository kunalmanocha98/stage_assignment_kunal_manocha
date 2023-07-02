import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_test/Dialog/custom_dialog.dart';
import 'package:stage_test/Models/Collections/task_collection.dart';
import 'package:stage_test/UI/CreatePage/create_page.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Strings/collection_constants.dart';
import 'package:stage_test/Utils/utility.dart';

/// This class serve as a provider to HomePage
class HomePageProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot> list = [];
  User? user = FirebaseAuth.instance.currentUser;
  DateTime? selectedDate;

  /// function to fetch tasks for a specific date
  void fetch(BuildContext context) {
    var nowTime = selectedDate ?? DateTime.now();
    var date = DateTime(nowTime.year, nowTime.month, nowTime.day);
    list.clear();
    FirebaseFirestore.instance
        .collection(Collections.tasks)
        .where(TaskConstants.uId, isEqualTo: user?.uid)
        .where(TaskConstants.targetDateTime,
            isGreaterThan:
                date.subtract(const Duration(days: 1)).millisecondsSinceEpoch)
        .where(TaskConstants.targetDateTime,
            isLessThan:
                date.add(const Duration(days: 1)).millisecondsSinceEpoch)
        .get()
        .then((response) {
          // tasks fetch successful
      list.addAll(response.docs);
      notifyListeners();
    }).catchError((onError) {
      // tasks fetch failed
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function used to clear fields
  void clear(){
    selectedDate = null;
    list.clear();
  }

  /// function to logout from the app
  void logout(BuildContext context) {
    // Dialog to show prompt to user
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomConfirmDialog(
          okCallback: (){
            // Users accepts
            Navigator.pop(context);
            FirebaseAuth
                .instance
                .signOut()
                .then((value) {
                  // User is logged out
                  clear();
              Utils().showSnackBar(Strings.loggedOutSuccessfully, context);
              fetch(context);
            }).catchError((onError) {
              // Logout failed
              Utils().showSnackBar(Strings.someErrorOccurred, context);
            });
          },
          cancelCallback: (){
            // User rejects
            Navigator.pop(context);
          },
          message: Strings.logoutConfirmation,
        );
      },
    );
  }

  /// function to delete the task
  void deleteData(BuildContext context, String path) {
    // Dialog to show prompt to user
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomConfirmDialog(
          okCallback: (){
            // User accepts
            Navigator.pop(context);
            FirebaseFirestore.instance
                .collection(Collections.tasks)
                .doc(path)
                .delete()
                .then((value) {
                  // Task deleted
              Utils().showSnackBar(Strings.deleteSuccessfully, context);
              fetch(context);
            }).catchError((onError) {
              // Task delete failed
              Utils().showSnackBar(Strings.someErrorOccurred, context);
            });
          },
          cancelCallback: (){
            // User rejects
            Navigator.pop(context);
          },
          message: Strings.deleteConfirmation,
        );
      },
    );
  }

  /// function to change status of task
  void markCompletion(BuildContext context, String path, bool isComplete) {
    FirebaseFirestore.instance
        .collection(Collections.tasks)
        .doc(path)
        .update({TaskConstants.isCompleted: isComplete}).then((value) {
          // Task change success
      Utils().showSnackBar(Strings.taskMarkedSuccessfully, context);
      fetch(context);
    }).catchError((onError) {
      // Task change failed
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to edit Task
  void edit(BuildContext context, TaskCollection value) {
    // Navigate to create page to edit the task
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return CreatePage(data: value);
    })).then((value) {
      if (value != null && value) {
        fetch(context);
      }
    });
  }

  void createNew(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return const CreatePage();
    })).then((value) {
      if (value != null && value) {
        fetch(context);
      }
    });
  }


}
