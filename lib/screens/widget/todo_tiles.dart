import 'package:flutter/material.dart';

import '../add_todo_list.dart';

class TodoTiles extends StatefulWidget {
  const TodoTiles({
    required this.title,
    required this.date,
    super.key,
    required this.del,
  });

  final String title;
  final DateTime date;
  final Function del;

  @override
  State<TodoTiles> createState() => _TodoTilesState();
}

class _TodoTilesState extends State<TodoTiles> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: ((value) {
          setState(() {
            isChecked = !isChecked;
          });
        }),
      ),
      trailing: GestureDetector(
        child: const Icon(Icons.delete),
        onTap: () {
          print(
            'deleted',
          );
          widget.del(widget.title);
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddTodoList(
                    isEdit: true,
                    title: widget.title,
                    data: [],
                  )),
        );
      },
      title: Text(widget.title),
      subtitle: Text(widget.date.toIso8601String()),
    );
  }
}
