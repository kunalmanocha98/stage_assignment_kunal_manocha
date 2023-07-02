import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stage_test/Models/Collections/task_collection.dart';
import 'package:stage_test/Utils/Strings/app_constants.dart';
import 'package:stage_test/Utils/Strings/collection_constants.dart';
import 'package:stage_test/Utils/utility.dart';

/// This class is used as a provider to Create Page
class CreateTaskProvider extends ChangeNotifier {
  // Selected date
  DateTime? selected;
  bool isLoading = false;
  bool isEdit = false;
  String? docId;
  // Current User
  User? user = FirebaseAuth.instance.currentUser;
  // Form Key used for validator
  GlobalKey<FormState> formKey = GlobalKey();
  // Text Editing controllers
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  /// function to call Material Date Picker
  void pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019, 1, 1),
      lastDate: DateTime(2024, 1, 1),
    ).then((date) {
      // Picked date
      if (date != null) {
        selected = date;
        dateController.text = Utils().getDateFormat(DateConstants.ddMMMYYYY, date);
        notifyListeners();
      }
    });
  }

  /// function to check fields
  void check(BuildContext context) {
    if (formKey.currentState!.validate()) {
      //Validation successful
      if (selected != null) {
        submit(context);
      } else {
        //Validation failed
        Utils().showSnackBar(Strings.pleaseSelectDate, context);
      }
    }
  }

  /// function to check fields during edit mode
  void checkAndSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (selected != null) {
        //Validation successful
        save(context);
      } else {
        //Validation failed
        Utils().showSnackBar(Strings.pleaseSelectDate, context);
      }
    }
  }

  /// function to save fields during edit mode
  void save(BuildContext context) {
    isLoading = true;
    notifyListeners();
    FirebaseFirestore.instance
        .collection(Collections.tasks)
        .doc(docId)
        .update({
      TaskConstants.title: titleController.text,
      TaskConstants.description: descriptionController.text,
      TaskConstants.targetDateTime: selected!.millisecondsSinceEpoch
    }).then((value) {
      // Update successful
      isLoading = false;
      clearData();
      Utils().showSnackBar(Strings.taskSavedSuccess, context);
      notifyListeners();
      Navigator.pop(context, true);
    }).onError((error, stackTrace) {
      // Update successful
      Utils().showSnackBar(Strings.someErrorOccurred, context);
    });
  }

  /// function to save fields in firestore
  void submit(BuildContext context) {
    isLoading = true;
    notifyListeners();
    var nowTime = DateTime.now();
    var dateTime = DateTime(nowTime.year,nowTime.month,nowTime.day);
    FirebaseFirestore.instance
        .collection(Collections.tasks)
        .add(TaskCollection(
                uId: user?.uid,
                title: titleController.text,
                description: descriptionController.text,
                isCompleted: false,
                createDateTime: dateTime.millisecondsSinceEpoch,
                targetDateTime: selected!.millisecondsSinceEpoch,
                completionDateTime: null)
            .toJson())
        .then((value) {
          // Task submission successful
      isLoading = false;
      clearData();
      Utils().showSnackBar(Strings.taskAddSuccess, context);
      notifyListeners();
      Navigator.pop(context, true);
    }).onError((error, stackTrace) {
      // Task submission failed
      Utils().showSnackBar(Strings.taskAddSuccess, context);
    });
  }

  /// function used to clear fields
  void clearData() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    selected = null;
  }

  /// function to setData into feilds
  void setData(TaskCollection? data) {
    if(data!=null){
      isEdit = true;
      docId = data.documentId;
      var date = DateTime.fromMillisecondsSinceEpoch(data.targetDateTime!);
      titleController.text = data.title!;
      descriptionController.text = data.description!;
      selected = date;
      dateController.text = Utils().getDateFormat(DateConstants.ddMMMYYYY, date);
      notifyListeners();
    }
  }
}
