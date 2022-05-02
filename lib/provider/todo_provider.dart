import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_unicode/widget/toast.dart';
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

  addTodo(
    TodoModel todoModel,
  ) {
    if (todoModel.title.trim() == "") {
      showToast(msg: "you should enter the title !", state: ToastState.error);
    } else {
      try {
        _fireStore.collection('todo').doc(todoModel.id).set(todoModel.toMap());
      } catch (e) {
        print("$e");
      }
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

  todoEdit(TodoModel todoModel) {
    try {
      _fireStore.collection('todo').doc(todoModel.id).update(todoModel.toMap());
    } catch (e) {
      print("$e");
    }
  }
}
