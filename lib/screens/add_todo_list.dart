import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart';
import 'package:todo/screens/widget/snackbar.dart';

class AddTodoList extends StatefulWidget {
  const AddTodoList(
      {super.key,
      required this.isEdit,
      this.title,
      this.description,
      required this.data});
  final bool isEdit;
  final String? title;
  final String? description;
  final List<dynamic> data;

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController description = TextEditingController();

  List nData = [];

  addTodo() {
    if (titleController.text == '') {
      snackBar(context, msg: 'Title can not be empty');
      return;
    }
    if (description.text == '') {
      snackBar(context, msg: 'Description can not be empty');
      return;
    }
    nData.add({'title': titleController.text});

    Navigator.pop(context, nData);
  }

  @override
  void initState() {
    for (var e in widget.data) {
      nData.add(e);
    }

    titleController.text = widget.title ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, widget.data);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Todo List'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              TextField(
                autocorrect: false,
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              TextField(
                controller: description,
                decoration: InputDecoration(hintText: 'Description'),
                autocorrect: false,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    addTodo();
                  },
                  child: Text('Add ToDo'))
            ],
          ),
        ),
      ),
    );
  }
}
