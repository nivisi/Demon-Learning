import 'package:flutter/foundation.dart';

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
}
