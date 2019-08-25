import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
//import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:TODO/list/TodoList.dart';
import 'package:TODO/AddForm.dart';
import 'package:TODO/model/AppState.dart';
import 'package:TODO/redux/actions.dart';
import 'package:TODO/redux/middleware.dart';
import 'package:TODO/redux/reducers.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

class TodoListApp extends StatelessWidget {
  final store = DevToolsStore<AppState>(appStateReducers,
      initialState: AppState.empty, middleware: [storeTodoItemsMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Relevant Todo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: StoreBuilder<AppState>(
            onInit: (store) => store.dispatch(FetchTodosAction()),
            builder: (context, store) => TodoListStore(store)),
      ),
    );
  }
}

class TodoListStore extends StatelessWidget {
  final DevToolsStore<AppState> store;

  TodoListStore(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relevant Todo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AddTodoForm(),
            SizedBox(
              height: 400,
              child: TodoList(),
            ),
          ],
        ),
      ),
    );
  }
}
