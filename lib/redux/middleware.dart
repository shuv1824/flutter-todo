import 'dart:async';
import 'dart:convert';

import 'package:TODO/model/AppState.dart';
import 'package:TODO/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String APP_STATE_KEY = "TODO_APP_STATE";

void storeTodoItemsMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is AddTodoAction || action is ToggleTodoStateAction || action is RemoveTodoAction) {
    saveStateToPrefs(store.state);
  }

  if (action is FetchTodosAction) {
    loadStateFromPrefs().then((state) {
      store.dispatch(TodoLoadedAction(state.todoItems));
    });
  }
  next(action);
}

void saveStateToPrefs(AppState state) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var stateString = json.encode(state.toJson());

  await preferences.setString(APP_STATE_KEY, stateString);
}

Future<AppState> loadStateFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var stateString = preferences.getString(APP_STATE_KEY);
  Map stateMap = json.decode(stateString);

  return AppState.fromJson(stateMap);
}