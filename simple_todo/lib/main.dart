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
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ).copyWith(
            secondary: const Color.fromARGB(255, 236, 179, 255),
          ),
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 236, 179, 255),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
        home: const TodosScreen(),
        routes: {
          TodoScreen.routeName: (context) => TodoScreen(),
        },
      ),
    );
  }
}
