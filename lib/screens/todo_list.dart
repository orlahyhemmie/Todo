import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/screens/add_todo_list.dart';
import 'package:todo/screens/widget/todo_tiles.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<dynamic> data = [];

  deleteItem(title) {
    setState(() {
      data.removeWhere((item) => item['title'] == title);
    });
  }

  @override
  void initState() {
    super.initState();

    for (var element in tileData) {
      data.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: data.length > 0
          ? ListView(
              children: data
                  .map(
                    (e) => Column(
                      children: [
                        TodoTiles(
                          title: e['title'],
                          date: DateTime.now(),
                          del: deleteItem,
                        ),
                        const Divider(
                          height: 5,
                          thickness: 0.8,
                        )
                      ],
                    ),
                  )
                  .toList())
          : Text('No record found'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoList(isEdit: false, data: data),
            ),
          ).then((value) {
            print('Result $value');
            setState(() {
              // data.add({'title': 'where', 'date': 'date here'});

              data = value;
            });
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
