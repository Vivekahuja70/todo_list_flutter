import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../state/todo_provider.dart';
import '../widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Todo Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a title'),
                  ),
                );
                return;
              }
              final todo = Todo(
                title: _titleController.text,
                isComplete: false,
              );
              Provider.of<TodoProvider>(context, listen: false).addTodoItem(todo);
              _titleController.clear();
            },
            child: const Text('Add Todo'),
          ),
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return ListView.builder(
                  itemCount: todoProvider.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoProvider.todos[index];
                    return TodoItem(todo: todo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
