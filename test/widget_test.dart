import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/models/todo.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  sqfliteFfiInit();
  TestWidgetsFlutterBinding.ensureInitialized();
  String table = "TodoList";
  var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  await db.execute(
      "CREATE TABLE TodoList(id integer primary key AUTOINCREMENT, title Text, content TEXT, status integer)");
  setUp(() async {});

  tearDownAll(() async {
    db.delete(table);
  });

  group("Database", () {
    test("Add a Todo", () async {
      expect((await db.query("TodoList")).isEmpty, true);

      Todo todo = new Todo.withId(
          id: 1, content: "asdsad", status: false, title: "adasdasd");

      db.insert("TodoList", todo.todoMap());

      expect((await db.query('TodoList')).length, 1);

      Todo todo1 = Todo(content: "haha", status: true, title: "aaaa");
      db.insert("TodoList", todo1.todoMap());
      db.insert("TodoList", todo1.todoMap());
      db.insert("TodoList", todo1.todoMap());

      expect((await db.query('TodoList')).length, 4);
      print(await db.query('TodoList'));
    });

    test("Update Compelete/Incompelete", () async {
      String id = "1";
      String status = "false";
      String sql = "UPDATE $table SET status = $status  WHERE id = $id;";
      db.rawUpdate(sql);
      expect((await db.query(table)).elementAt(0)['status'], 0);
      print(await db.query('TodoList'));
    });
  });
}
