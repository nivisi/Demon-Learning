import 'package:flutter/material.dart';

import './todo_model.dart';

class TodoList with ChangeNotifier {
  final List<TodoModel> _todolist = [];

  List<TodoModel> get todolist {
    return [..._todolist];
  }

  void addTodo(TodoModel? todo) {
    if (todo == null) {
      return;
    }
    _todolist.add(todo);
    notifyListeners();
  }

  void updateTodo(TodoModel? todo) {
    final todoIndex = _todolist.indexWhere((td) => td.id == todo!.id);
    if (todoIndex >= 0) {
      _todolist[todoIndex] = todo!;
      notifyListeners();
    }
  }

  void deleteTodo(String? id, BuildContext context) {
    final existingTodoIndex = _todolist.indexWhere((td) => td.id == id);
    _todolist.removeAt(existingTodoIndex);
    notifyListeners();
    Navigator.of(context).pop();
  }
}
