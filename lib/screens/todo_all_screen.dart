import 'package:flutter/material.dart';
import 'package:todo_application/Screens/dialog_add_wigdet.dart';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/services/todo_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late List<Todo> todos = <Todo>[];
  List<Todo> updateTodos = <Todo>[];
  List<Todo> listTodos = <Todo>[];
  bool value = false;

  //Todo Services
  var todoService = TodoService();

  void deleteData() async {
    todoService.deleteList();
  }

  void getData() async {
    listTodos = await todoService.getTodoList();
    showAll();
  }

  void showAll() async {
    todos.clear();
    todos = listTodos.toList();
  }

  void showCompelete() async {
    updateTodos.clear();
    updateTodos = listTodos.where((element) => element.status == true).toList();
    todos = updateTodos.toList();
  }

  void showIncompelete() async {
    updateTodos.clear();
    updateTodos =
        listTodos.where((element) => element.status == false).toList();
    todos = updateTodos.toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: todoService.getTodoList(),
          builder: (context, snapshot) {
            todos = snapshot.data ?? [];
            return Container(
              padding: EdgeInsets.all(8),
              child: Center(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return ListTile(
                      subtitle: Text(todo.content!),
                      onTap: () {
                        setState(() {
                          todo.status = !todo.status!;
                          if (todo.status == false) {
                            todoService.updateList(todo.id, 0);
                          } else {
                            todoService.updateList(todo.id, 1);
                          }
                        });
                        try {} catch (e) {
                          print(e);
                        }
                      },
                      title: Text(todo.title!),
                      trailing: Checkbox(
                        value: todo.status,
                        onChanged: (value) {},
                      ),
                    );
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.amber,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DialogAdd(
              callback: () {
                _currentIndex = 0;
                listTodos.clear();
                getData();
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 1) {
              showCompelete();
            } else if (_currentIndex == 2) {
              showIncompelete();
            } else {
              showAll();
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.fact_check), label: "All"),
          BottomNavigationBarItem(icon: Icon(Icons.check), label: "Compelete"),
          BottomNavigationBarItem(
              icon: Icon(Icons.close), label: "Incompelete"),
        ],
      ),
    );
  }
}
