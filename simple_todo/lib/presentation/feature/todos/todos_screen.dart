import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/domain/todo_list.dart';

/// Displays the list of all the todo items.
class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<TodoList>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your to-do list'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: todo.todolist.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Here is empty list!\nAdd your first To Do!'),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            )
          : 
    );
  }
}
