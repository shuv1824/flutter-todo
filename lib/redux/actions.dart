import 'package:TODO/model/TodoItem.dart';

class AddTodoAction {
  final TodoItem item;

  AddTodoAction(this.item);
}

class ToggleTodoStateAction {
  final TodoItem item;

  ToggleTodoStateAction(this.item);
}

class FetchTodosAction {}

class TodoLoadedAction {
  final List<TodoItem> items;

  TodoLoadedAction(this.items);
}

class RemoveTodoAction {
  final TodoItem item;

  RemoveTodoAction(this.item);
}