import 'package:flutter/foundation.dart';

import './todo_model.dart';

class TodoList with ChangeNotifier {
  final List<TodoModel> _todolist = [];

  List<TodoModel> get todolist {
    return [..._todolist];
  }
}
