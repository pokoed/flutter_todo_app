import 'package:flutter/material.dart';

class ToDo {
  bool isDone = false; // 현재 진행여부
  String title; // 할일
  ToDo(this.title);
}

void main() {
  runApp(MyApp());
}

class _ToDoListPageState extends State<ToDoListPage> {
  // 할일 저장할 리스트
  final _items = <ToDo>[];
  // 할일 문자열 다룰 컨트롤러
  var _todoController = TextEditingController();

  // 할 일 추가 메소드
  void _addTodo(ToDo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = ''; // 할일을 리스트에 추가하며 할일 입력 필드 비우기
    });
  }

  // 할 일 삭제 메소드
  void _deleteTodo(ToDo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  // 할 일 완료/미완료 메소드
  void _toggleTodo(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  @override
  void dispose() {
    _todoController.dispose(); // 컨트롤러는 종료시 반드시 해제해줘야 함
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Left To Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoController, // 입력한 TextField 컨트롤러로 조작
                  ),
                ),
                RaisedButton(
                  onPressed: () => _addTodo(ToDo(_todoController.text)),
                  color: Colors.purple,
                  child: Text('Add', style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: _items.map((todo) => _buildItemWidget(todo)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildItemWidget(ToDo todo) {
    return ListTile(
      onTap: () => _toggleTodo(todo), // 완료/미완료 상태변경
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _deleteTodo(todo), // 할일 삭제하기
      ),
      title: Text(
        todo.title,
        style: todo.isDone? // 할일 완료 여부로 스타일 변경
        TextStyle(
          decoration: TextDecoration.lineThrough, color: Colors.grey, // 취소선
        ) : null
        ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}