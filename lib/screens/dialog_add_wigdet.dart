import 'package:flutter/material.dart';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/services/todo_service.dart';

// ignore: must_be_immutable
class DialogAdd extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final VoidCallback callback;

  TextEditingController _titleTextFormField = TextEditingController();
  TextEditingController _contenttextFormField = TextEditingController();
  DialogAdd({Key key, @required this.callback}) : super(key: key);

  void addTodo(Todo todo) {
    var todoService = TodoService();
    try {
      todoService.addItemList(todo);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: AlertDialog(
          title: Text("Add Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: _titleTextFormField,
                validator: (input) =>
                    input.trim().isEmpty ? "Plese enter title" : null,
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextFormField(
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    labelText: "Content",
                    labelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
                controller: _contenttextFormField,
                validator: (input) =>
                    input.trim().isEmpty ? "Plese enter content" : null,
              ),
            ],
          ),
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  if (_key.currentState.validate()) {
                    Todo todo = new Todo(
                        title: _titleTextFormField.text,
                        content: _contenttextFormField.text,
                        status: false);
                    addTodo(todo);
                    Navigator.pop(context);
                    callback();
                  }
                
                },
                child: Text("Add")),
          ],
        ));
  }
}
