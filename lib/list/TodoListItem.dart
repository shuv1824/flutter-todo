import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:TODO/model/AppState.dart';
import 'package:TODO/model/TodoItem.dart';
import 'package:TODO/redux/actions.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem item;

  TodoListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          item.todo,
          style: TextStyle(decoration: item.isDone ? TextDecoration.lineThrough : TextDecoration.none),
      ),
      leading: StoreConnector<AppState, OnStateChanged>(converter: (store) {
        return (item) => store.dispatch(ToggleTodoStateAction(item));
      }, builder: (context, callback) {
        return Checkbox(
            value: item.isDone,
            onChanged: (bool newValue) {
              callback(TodoItem(item.todo, newValue));
            });
      }),
      trailing: StoreConnector<AppState, OnRemoveIconClicked>(
        converter: (store) {
          return (item) => store.dispatch(RemoveTodoAction(item));
        },
        builder: (context, callback) {
          return IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.red,
            tooltip: 'Remove from list',
            onPressed: () {
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Are you sure?'),
                    content: const Text('This todo will be removed from the list'),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          callback(TodoItem(item.todo, item.isDone));
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

typedef OnStateChanged = Function(TodoItem item);

typedef OnRemoveIconClicked = Function(TodoItem item);