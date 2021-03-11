import 'dart:core';

import 'package:todo_application/models/todo.dart';
import 'package:todo_application/repositories/repostitory.dart';

class TodoService {
  Repository _repository;
  TodoService() {
    _repository = Repository();
  }

  addItemList(Todo todo) async {
    return await _repository.insertData('TodoList', todo.todoMap());
  }

  readList() async {
    return await _repository.readData('TodoList');
  }

  deleteList() async {
    return await _repository.deleteData('TodoList');
  }

  updateList(int id, int status) async {
    return await _repository.updateData('TodoList',  id, status);
  }
}
