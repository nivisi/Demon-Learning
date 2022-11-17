import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './todo_model.dart';

class TodoList with ChangeNotifier {
  List<TodoModel> _todolist = [];

  List<TodoModel> get todolist {
    return [..._todolist];
  }

  static const String _userList = '_userList';

  List<TodoModel> _todoListFromJson(String jsonString) {
    final extractedMap = json.decode(jsonString) as Map<String, dynamic>;
    return [
      ...(extractedMap['userList'] as List<dynamic>).map(
        (td) => TodoModel(
            id: td['id'],
            title: td['title'],
            createdAt: DateTime.parse(td['createdAt']),
            description: td['description'],
            isComplete: td['isComlete']),
      ),
    ];
  }

  String _todoListToJson() {
    return json.encode({
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
  }

  Future<void> fethAndSetData() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    if (!_sharedPrefs.containsKey(_userList)) {
      return;
    }
    final jsonString = _sharedPrefs.getString(_userList);
    if (jsonString == null) {
      return;
    }
    _todolist = _todoListFromJson(jsonString);
    notifyListeners();
  }

  Future<void> addTodo(TodoModel? todo) async {
    if (todo == null) {
      return;
    }
    _todolist.add(todo);
    notifyListeners();
    final sharedPrefs = await SharedPreferences.getInstance();
    if (!sharedPrefs.containsKey(_userList)) {
      sharedPrefs.setString(_userList, _todoListToJson());
    } else {
      sharedPrefs.clear();
      sharedPrefs.setString(_userList, _todoListToJson());
    }
  }

  Future<void> updateTodo(TodoModel? todo) async {
    final todoIndex = _todolist.indexWhere((td) => td.id == todo!.id);
    if (todoIndex >= 0) {
      _todolist[todoIndex] = todo!;
      notifyListeners();
      final sharedPrefs = await SharedPreferences.getInstance();
      if (!sharedPrefs.containsKey(_userList)) {
        return;
      }
      final jsonString = sharedPrefs.getString(_userList);
      if (jsonString == null) {
        return;
      }
      sharedPrefs.clear();
      final privateList = _todoListFromJson(jsonString);
      privateList[todoIndex] = todo;
      sharedPrefs.setString(_userList, _todoListToJson());
    }
  }

  Future<void> deleteTodo(String? id) async {
    final existingTodoIndex = _todolist.indexWhere((td) => td.id == id);
    _todolist.removeAt(existingTodoIndex);
    notifyListeners();
    final sharedPrefs = await SharedPreferences.getInstance();
    final jsonString = sharedPrefs.getString(_userList);
    if (jsonString == null) {
      return;
    }
    sharedPrefs.clear();
    final privateList = _todoListFromJson(jsonString);
    privateList.removeAt(existingTodoIndex);
    sharedPrefs.setString(_userList, _todoListToJson());
  }
}
