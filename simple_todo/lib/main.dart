import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './domain/todo_list.dart';
import 'package:simple_todo/presentation/feature/todos/todos_screen.dart';
import './presentation/feature/todo/todo_screen.dart';

void main() {
  // Here you can init your data.
  // For now, simply store it in shared prefs.

  // https://pub.dev/packages/shared_preferences

  runApp(const SimpleTodoApp());
}

class SimpleTodoApp extends StatelessWidget {
  const SimpleTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoList>(
      create: (context) => TodoList(),
      child: MaterialApp(
        title: 'Simple TODO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosScreen(),
        routes: {
          TodoScreen.routeName: (context) => TodoScreen(),
        },
      ),
    );
  }
}
