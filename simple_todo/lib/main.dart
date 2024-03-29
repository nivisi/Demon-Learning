import 'package:flutter/material.dart';
import 'package:simple_todo/presentation/feature/todos/todos_screen.dart';

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
    return MaterialApp(
      title: 'Simple TODO App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodosScreen(),
    );
  }
}
