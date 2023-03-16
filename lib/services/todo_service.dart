import 'dart:core';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/repositories/repostitory.dart';

class TodoService {
  late Repository _repository;
  List<Todo> todos = [];
  TodoService() {
    _repository = Repository();
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    final List<Map<String, dynamic>> result =
        await _repository.readData('TodoList');
    return result;
  }

  Future<List<Todo>> getTodoList() async {
    final List<Map<String, dynamic>> todoMapList = await getTodoMapList();
    final List<Todo> todoList = [];
    todoMapList.forEach((element) {
      todoList.add(Todo.fromJson(element));
    });
    return todoList;
  }

  Future<void> addItemList(Todo todo) async {
    return await _repository.insertData('TodoList', todo.todoMap());
  }

  Future<void> readList() async {
    return await _repository.readData('TodoList');
  }

  Future<void> deleteList() async {
    return await _repository.deleteData('TodoList');
  }

  Future<void> updateList(int? id, int status) async {
    return await _repository.updateData('TodoList', id, status);
  }
}
