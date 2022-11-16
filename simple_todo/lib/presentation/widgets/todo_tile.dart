import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_todo/presentation/feature/todo/todo_screen.dart';
import '/domain/todo_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (_, todo, ch) => Card(
        margin: const EdgeInsets.all(5),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => TodoScreen(model: todo),
              ),
            );
          },
          leading: FittedBox(
            child: Checkbox(
              fillColor: MaterialStateColor.resolveWith(
                (states) => Theme.of(context).colorScheme.primary,
              ),
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
      ),
    );
  }
}
