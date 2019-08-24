import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relevant TODO',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Relevant TODO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var todos = <Map>[];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  //Loading todos from shared preference
  _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
//      if(prefs.getString('todos') != null){
        Iterable it  = jsonDecode(prefs.getString('todos'));
        it.map((todo) => todos.add(todo)).toList();
//      }
    });
  }

  _refreshStorage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('todos');
    prefs.setString('todos', jsonEncode(todos));
  }

  void _addTodoToList() {
    if(_controller.text != ''){
      setState(() {
        var todo = {};
        todo['todo'] = _controller.text;
        todo['isDone'] = false;
        this.todos.add(todo);
        _controller.clear();
        _refreshStorage();
      });
    }
  }

  Widget todoItem(Map todo, int index) {
    return new Container(
      child: Row(
        children: <Widget>[
          new Checkbox(
            value: todo['isDone'],
            onChanged: (bool newVal){
              setState(() {
                this.todos[index]['isDone'] = newVal;
              });
              _refreshStorage();
            },
          ),
          Expanded(
            child: Text(
                todo['todo'],
                style: TextStyle(decoration: todo['isDone'] ? TextDecoration.lineThrough : TextDecoration.none),
            ),
          ),
          IconButton(
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
                          setState(() {
                            this.todos.removeAt(index);
                          });
                          Navigator.pop(context);
                          _refreshStorage();
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
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
                      _addTodoToList();
                    },
                    child: Text('ADD'),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: new ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(8.0),
                itemCount: todos.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return todoItem(todos[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
