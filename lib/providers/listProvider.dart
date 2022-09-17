import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/todo.dart';

class ListProvider extends ChangeNotifier {
  List<Todo> todos = [];
  DateTime selectedDate = DateTime.now();
  void getTodosFireStore() async {
    QuerySnapshot querySnapshot = await Todo.getCollectionRef().get();
    todos = querySnapshot.docs.map((doc) {
      Map docAsMap = doc.data() as Map;
      return Todo(
          id: doc.id,
          title: docAsMap["title"],
          details: docAsMap["details"],
          cheeked: docAsMap["cheeked"],
          dateTime: DateTime.fromMillisecondsSinceEpoch(docAsMap["dateTime"]));
    }).toList();
    todos = todos.where((todo) {
      if (todo.dateTime.year == selectedDate.year &&
          todo.dateTime.month == selectedDate.month &&
          todo.dateTime.day == selectedDate.day) {
        return true;
      }
      return false;
    }).toList();
    todos.sort((Todo t1 , Todo t2){
      return t1.dateTime.compareTo(t2.dateTime);
    });
    notifyListeners();
  }

  void setNewSlelected(DateTime newdate) {
    selectedDate = newdate;
    notifyListeners();
  }
}
