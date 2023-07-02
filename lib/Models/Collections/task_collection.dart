
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskCollection {
  String? title;
  String? description;
  String? uId;
  bool? isCompleted;
  int? targetDateTime;
  int? completionDateTime;
  int? createDateTime;
  String? documentId;

  TaskCollection(
      {this.title,
        this.description,
        this.uId,
        this.isCompleted,
        this.targetDateTime,
        this.completionDateTime,
        this.createDateTime,
        this.documentId
      });


  TaskCollection.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    uId = json['uId'];
    isCompleted = json['isCompleted'];
    targetDateTime = json['targetDateTime'];
    completionDateTime = json['completionDateTime'];
    createDateTime = json['createDateTime'];
  }

  TaskCollection.fromFirestore(QueryDocumentSnapshot json){
    documentId = json.id;
    title = json['title'];
    description = json['description'];
    uId = json['uId'];
    isCompleted = json['isCompleted'];
    targetDateTime = json['targetDateTime'];
    completionDateTime = json['completionDateTime'];
    createDateTime = json['createDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['uId'] = uId;
    data['isCompleted'] = isCompleted;
    data['targetDateTime'] = targetDateTime;
    data['completionDateTime'] = completionDateTime;
    data['createDateTime'] = createDateTime;
    return data;
  }
}