import 'package:flutter/material.dart';

import './todo_model.dart';

class TodoList with ChangeNotifier {
  final List<TodoModel> _todolist = [];

  List<TodoModel> get todolist {
    return [..._todolist];
  }

  static const String _userList = '_userList';

  Future<void> fethAndSetData() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    if (!_sharedPrefs.containsKey(_userList)) {
      return;
    }
    final jsonString = _sharedPrefs.getString(_userList);
    if (jsonString == null) {
      return;
    }
    final extractedMap = json.decode(jsonString) as Map<String, dynamic>;
    final List<TodoModel> _localList = [
      ...(extractedMap['userList'] as List<dynamic>).map(
        (td) => TodoModel(
            id: td['id'],
            title: td['title'],
            createdAt: DateTime.parse(td['createdAt']),
            description: td['description'],
            isComplete: td['isComlete']),
      ),
    ];
    _todolist = _localList;
    notifyListeners();
  }

  Future<void> addTodo(TodoModel? todo) async {
    if (todo == null) {
      return;
    }
    _todolist.add(todo);
    notifyListeners();
    final todoJson = json.encode({
      'userList': _todolist
          .map((td) => {
                'id': td.id,
                'title': td.title,
                'description': td.description,
                'createdAt': td.createdAt.toIso8601String(),
                'isComlete': td.isComplete,
              })
          .toList(),
    });
    final sharedPrefs = await SharedPreferences.getInstance();
    if (!sharedPrefs.containsKey(_userList)) {
      sharedPrefs.setString(_userList, todoJson);
    } else {
      sharedPrefs.clear();
      sharedPrefs.setString(_userList, todoJson);
    }
  }

  void updateTodo(TodoModel? todo) {
    final todoIndex = _todolist.indexWhere((td) => td.id == todo!.id);
    if (todoIndex >= 0) {
      _todolist[todoIndex] = todo!;
      notifyListeners();
    }
  }

  void deleteTodo(String? id) {
    final existingTodoIndex = _todolist.indexWhere((td) => td.id == id);
    _todolist.removeAt(existingTodoIndex);
    notifyListeners();
  }
}
