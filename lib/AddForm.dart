import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:TODO/model/AppState.dart';
import 'package:TODO/model/TodoItem.dart';
import 'package:TODO/redux/actions.dart';

class AddTodoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnItemAddedCallback>(
      converter: (store) {
        return (todo) => store.dispatch(
          AddTodoAction(TodoItem(todo, false)),
        );
      },
      builder: (context, callback) {
        return AddTodoFormWidget(callback);
      },
    );
  }
}

class AddTodoFormWidget extends StatefulWidget {
  final OnItemAddedCallback callback;

  AddTodoFormWidget(this.callback);

  @override
  State<StatefulWidget> createState() => AddTodoFormWidgetState(callback);
}

class AddTodoFormWidgetState extends State<AddTodoFormWidget> {
  final OnItemAddedCallback callback;

  AddTodoFormWidgetState(this.callback);

  TextEditingController _textFieldController = TextEditingController();

  _onClear() {
    setState(() {
      _textFieldController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.zero,
                  ),
                ),
                labelText: 'Add a task to the list',
              ),
//              onChanged: _handleTextChanged,
            ),
          ),
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            padding: EdgeInsets.all(21.0),
            splashColor: Colors.greenAccent,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(5.0),
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(5.0),
              ),
            ),
            onPressed: () {
              if(_textFieldController.text != ""){
                callback(_textFieldController.text);
                _onClear();
              }
            },
            child: Text('ADD'),
          )
        ],
      ),
    );
  }
}

typedef OnItemAddedCallback = Function(String itemName);