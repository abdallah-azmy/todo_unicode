import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/todo.dart';

class TodosProvider {
  List<TodoModel> allTodo = [];
  TodosProvider();

  TodosProvider.fromMap(QuerySnapshot<Map<String, dynamic>> todoSnapShots) {
    for (var doc in todoSnapShots.docs) {
      allTodo.add(TodoModel.fromMap(doc.data()));
    }
  }
  List<TodoModel> get todos =>
      allTodo.where((todo) => todo.isDone == false).toList();
  List<TodoModel> get complete =>
      allTodo.where((todo) => todo.isDone == true).toList();
}

Stream<TodosProvider>? getTodo() {
  return FirebaseFirestore.instance
      .collection("todo")
      .snapshots()
      .map((todo) => TodosProvider.fromMap(todo));
}

class ControlTodo with ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String? title;
  String? description;

  addTodo({id}) {
    var now = DateTime.now();
    TodoModel? _forMe = TodoModel(
        id: id,
        title: title!,
        createdTime: now,
        description: description!,
        isDone: false);
    try {
      _fireStore.collection('todo').doc(id).set(_forMe.toMap(_forMe));
      id = null;
      title = null;
      description = null;
    } catch (e) {
      print("$e");
    }
  }

  todoComplete({String? id, bool? value}) {
    try {
      _fireStore.collection('todo').doc(id).update({'isDone': value});
    } catch (e) {
      print("$e");
    }
  }

  todoDelete({
    String? id,
  }) {
    try {
      _fireStore.collection('todo').doc(id).delete();
    } catch (e) {
      print("$e");
    }
  }

  todoEdit({id}) {
    try {
      if (title != null) {
        _fireStore.collection('todo').doc(id).update({
          'title': title,
        });
      }
      if (description != null) {
        _fireStore
            .collection('todo')
            .doc(id)
            .update({'description': description});
      }

      title = null;
      description = null;
    } catch (e) {
      print("$e");
    }
  }
}
