import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import 'package:simple_todo/domain/todo_model.dart';
import 'package:simple_todo/domain/todo_list.dart';

/// Displays the details about the given todo.
class TodoScreen extends StatefulWidget {
  static const routeName = '/todo-details';
  TodoScreen({
    super.key,
    this.model,
  });

  TodoModel? model;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool exist = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _descriptionFocusNode = FocusNode();

  void _saveForm() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState!.save();
    if (exist) {
      Provider.of<TodoList>(
        context,
        listen: false,
      ).updateTodo(widget.model);
    } else {
      Provider.of<TodoList>(context, listen: false).addTodo(widget.model);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.model == null) {
      exist = false;
    } else {
      exist = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO details'),
        centerTitle: true,
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(
                color: Colors.white,
              ),
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.secondary),
              textTheme: const TextTheme().apply(bodyColor: Colors.white),
            ),
            child: exist
                ? PopupMenuButton<int>(
                    shape: Border.all(
                          width: 0.5,
                          color: Colors.white,
                        ) +
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                    icon: const Icon(Icons.more_vert),
                    color: Theme.of(context).colorScheme.primary,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => widget.model!.toggleCompleteStatus(),
                        child: widget.model!.isComplete
                            ? Row(
                                children: const [
                                  Icon(
                                    Icons.check_box_outline_blank,
                                  ),
                                  Text(' Uncompleted')
                                ],
                              )
                            : Row(
                                children: const [
                                  Icon(
                                    Icons.check_box,
                                  ),
                                  Text(' Complete')
                                ],
                              ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.save,
                            ),
                            Text(' Save Todo')
                          ],
                        ),
                        onTap: () => _saveForm(),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete,
                            ),
                            Text(' Delete'),
                          ],
                        ),
                        onTap: () =>
                            Provider.of<TodoList>(context, listen: false)
                                .deleteTodo(widget.model!.id, context),
                      ),
                    ],
                  )
                : IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: _saveForm,
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: exist ? widget.model?.title : null,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                validator: (value) {
                  if (value == null) {
                    return 'Please write your title';
                  } else if (value.isEmpty) {
                    return 'Please write your title';
                  }
                  return null;
                },
                onSaved: (newValue) => widget.model = TodoModel(
                  id: exist ? widget.model!.id : const Uuid().v1(),
                  title: newValue!,
                  createdAt: exist ? widget.model!.createdAt : DateTime.now(),
                ),
              ),
              TextFormField(
                initialValue: exist ? widget.model?.description : null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 5,
                textInputAction: TextInputAction.send,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (_) => _saveForm(),
                onSaved: (newValue) => widget.model = TodoModel(
                  id: widget.model!.id,
                  title: widget.model!.title,
                  createdAt: widget.model!.createdAt,
                  description: newValue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _saveForm();
                },
                label: const Text('Add'),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
