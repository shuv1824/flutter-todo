import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:TODO/list/TodoListItem.dart';
import 'package:TODO/model/AppState.dart';
import 'package:TODO/model/TodoItem.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<TodoItem>>(
      converter: (store) => store.state.todoItems,
      builder: (context, list) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, position) => TodoListItem(list[position]),
        );
      },
    );
  }
}