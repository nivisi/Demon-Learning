import 'package:flutter/material.dart';
import 'package:simple_todo/domain/todo_model.dart';

/// Displays the details about the given todo.
class TodoScreen extends StatefulWidget {
  const TodoScreen({
    super.key,
    required this.model,
  });

  final TodoModel? model;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    bool exist;
    if (widget.model == null) {
      exist = false;
    } else {
      exist = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('What\'s here?'),
        actions: [
          exist
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                )
              : IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {},
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(),
        ),
      ),
    );
  }
}
