import 'package:TODO/model/TodoItem.dart';

class AppState {
  static var empty = AppState(new List());

  final List<TodoItem> todoItems;

  AppState(this.todoItems);

  AppState.fromJson(Map<String, dynamic> json)
      : todoItems = (json['todoItems'] as List)
        .map((i) => new TodoItem.fromJson(i as Map<String, dynamic>))
        .toList();

  Map<String, dynamic> toJson() => {'todoItems': todoItems};

  @override
  String toString() => "$todoItems";
}