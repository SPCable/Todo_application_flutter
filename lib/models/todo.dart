class Todo {
  int id;
  String title;
  String content;
  bool status;
  Todo.withId({this.id, this.title, this.content, this.status});
  Todo({this.title, this.content, this.status});

  Map<String, dynamic> todoMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['content'] = content;
    if (status == false) {
      mapping['status'] = "false";
    } else {
      mapping['status'] = "true";
    }

    return mapping;
  }

  factory Todo.fromJson(Map<String, dynamic> map) {
    return Todo.withId(
      id: map['id'],
      content: map['content'],
      status: map['status'],
      title: map['title'],
    );
  }
}
