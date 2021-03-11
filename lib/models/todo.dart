class Todo {
  int id;
  String title;
  String content;
  bool status;
  Todo({this.id, this.title, this.content, this.status});

  todoMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['content'] = content;
    mapping['status'] = status;
    return mapping;
  }
}
