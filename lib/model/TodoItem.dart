class TodoItem {
  String todo;
  bool isDone;

  TodoItem(this.todo, this.isDone);

  TodoItem.fromJson(Map<String, dynamic> json)
      : todo = json['todo'],
        isDone = json['isDone'];

  Map<String, dynamic> toJson() => {'todo': this.todo, 'isDone': this.isDone};

  @override
  String toString() {
    return "$todo: $isDone";
  }
}