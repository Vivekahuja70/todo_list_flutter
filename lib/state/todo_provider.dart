import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/db_helper.dart';


class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  final DBHelper _dbHelper = DBHelper();

  TodoProvider() {
    fetchTodos();
  }

  void fetchTodos() async {
    _todos = await _dbHelper.getTodos();
    notifyListeners();
  }

  void addTodoItem(Todo todo) async {
    await _dbHelper.insertTodoItem(todo);
    fetchTodos();
  }

  void updateTodoItem(Todo todo) async {
    await _dbHelper.updateTodoItem(todo);
    fetchTodos();
  }

  void deleteTodoItem(int id) async {
    await _dbHelper.deleteTodoItem(id);
    fetchTodos();
  }
}
