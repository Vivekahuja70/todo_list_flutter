import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../state/todo_provider.dart';


class TodoItem extends StatelessWidget {
  final Todo todo;

  TodoItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.isComplete,
        onChanged: (value) {
          Provider.of<TodoProvider>(context, listen: false).updateTodoItem(
            Todo(
              id: todo.id,
              title: todo.title,
              isComplete: value!,
            ),
          );
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          Provider.of<TodoProvider>(context, listen: false).deleteTodoItem(todo.id!);
        },
      ),
    );
  }
}
