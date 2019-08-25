import 'package:TODO/model/AppState.dart';
import 'package:TODO/model/TodoItem.dart';
import 'package:TODO/redux/actions.dart';

AppState appStateReducers(AppState state, dynamic action) {
  if (action is AddTodoAction) {
    return addTodo(state.todoItems, action);
  } else if (action is ToggleTodoStateAction) {
    return toggleTodoState(state.todoItems, action);
  } else if (action is RemoveTodoAction) {
    return removeTodo(state.todoItems, action);
  } else if (action is TodoLoadedAction) {
    return loadTodos(action);
  }

  return state;
}

AppState addTodo(List<TodoItem> items, AddTodoAction action) {
  print(action);
  return AppState(List.from(items)..add(action.item));
}

AppState toggleTodoState(List<TodoItem> items, ToggleTodoStateAction action) {
  return AppState(items.map((item) => item.todo == action.item.todo ? action.item : item).toList());
}

AppState removeTodo(List<TodoItem> items, RemoveTodoAction action) {
  return AppState(List.from(items)..removeWhere((item) => item.todo == action.item.todo));
}

AppState loadTodos(TodoLoadedAction action) {
  return AppState(action.items);
}