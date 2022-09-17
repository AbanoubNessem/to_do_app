import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  String details;
  bool cheeked;
  DateTime dateTime;

  Todo(
      {required this.id,
      required this.title,
      required this.details,
      required this.cheeked,
      required this.dateTime});
  static CollectionReference getCollectionRef() {
    return FirebaseFirestore.instance.collection("todos");
  }
}
