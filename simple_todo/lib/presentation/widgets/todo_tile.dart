import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/domain/todo_list.dart';
import '/presentation/feature/todo/todo_screen.dart';
import '/domain/todo_model.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoModel>(
      builder: (_, todo, ch) => Dismissible(
        key: ValueKey(
          todo.id,
        ),
        confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Delete?',
            ),
            content: const Text(
              'Do you want to delete this todo?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text(
                  'Yes',
                ),
              )
            ],
          ),
        ),
        background: Container(
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(
            right: 20,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => Provider.of<TodoList>(
          context,
          listen: false,
        ).deleteTodo(
          todo.id,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
          ),
          margin: const EdgeInsets.all(
            5.0,
          ),
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => TodoScreen(
                    model: todo,
                  ),
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
                  ? const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 20,
                    )
                  : const TextStyle(
                      fontSize: 20,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
