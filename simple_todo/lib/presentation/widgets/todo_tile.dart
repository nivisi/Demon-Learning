import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/domain/todo_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (_, todo, ch) => ListTile(
        leading: FittedBox(
          child: Checkbox(
            value: todo.isComplete,
            onChanged: (_) {
              todo.toggleCompleteStatus();
            },
          ),
        ),
        title: Text(
          todo.title,
          style: todo.isComplete
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
      ),
    );
  }
}
