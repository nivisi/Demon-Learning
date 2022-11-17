import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/todo_tile.dart';
import '/domain/todo_list.dart';
import '../todo/todo_screen.dart';

/// Displays the list of all the todo items.
class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  Future? todosFuture;

  Future _obtainTodo() {
    return Provider.of<TodoList>(
      context,
      listen: false,
    ).fethAndSetData();
  }

  @override
  void initState() {
    todosFuture = _obtainTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<TodoList>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Your to-do list',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                TodoScreen.routeName,
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: todosFuture,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : todo.todolist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Here is empty list!\nAdd your first To Do!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              TodoScreen.routeName,
                            );
                          },
                          child: const Icon(
                            Icons.add,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: todo.todolist.length,
                    itemBuilder: (context, i) => ChangeNotifierProvider.value(
                      value: todo.todolist[i],
                      child: const TodoTile(),
                    ),
                  ),
      ),
      floatingActionButton: todo.todolist.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed(
                TodoScreen.routeName,
              ),
              child: const Icon(Icons.add),
            ),
    );
  }
}
