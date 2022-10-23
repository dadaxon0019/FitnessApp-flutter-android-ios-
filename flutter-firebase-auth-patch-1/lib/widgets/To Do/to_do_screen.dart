import 'package:firebase_auth_demo/data/database.dart';
import 'package:firebase_auth_demo/main.dart';
import 'package:firebase_auth_demo/widgets/To%20Do/todo_tile.dart';
import 'package:firebase_auth_demo/utils/constants/colors.dart';
import 'package:firebase_auth_demo/utils/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/my_button.dart';

class ToDoScreen extends StatefulWidget {
  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  //reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is 1st time ever opening the app,then create default data
    if (_myBox.get('TODOLIST') == null) {
      db.creatInitialData();
    } else {
      //the already exists data
      db.loadData();
    }
    super.initState();
  }

  //text controller
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  //chekBoxChanged was tapped
  void chekBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList1[index][2] = !db.toDoList1[index][2];
    });
    db.upDateBase();
  }
  //save new task

  void saveNewTask() {
    setState(() {
      db.toDoList1.add([_controller1.text, _controller2.text, false]);

      _controller1.clear();
      _controller2.clear();
    });
    Navigator.of(context).pop();
    db.upDateBase();
  }

  //create createNewTask
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          mainTitle: _controller1,
          descriptionTitle: _controller2,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //clear all tasks
  void clearAllTask() {
    setState(() {
      db.toDoList1.clear();
    });
    db.upDateBase();
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList1.removeAt(index);
    });
    db.upDateBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text('My Plans'),
        backgroundColor: mainColor,
        elevation: 2,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            padding: EdgeInsets.only(left: 20, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add events',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                Expanded(child: Container()),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 20,
                  iconSize: 35,
                  onPressed: createNewTask,
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 20,
                  iconSize: 35,
                  onPressed: () {
                    AlertDialog alert = AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      title: const Text('Are you sure ?'),
                      content: const Text('All Task will be delete!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(
                            context,
                            'Cancel',
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.indigo),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            clearAllTask();
                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.indigo),
                          ),
                        ),
                      ],
                    );
                    db.toDoList1.isNotEmpty
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          )
                        : null;
                  },
                  icon: Icon(
                    Icons.clear_all,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          db.toDoList1.isEmpty
              ? Container(
                  padding: EdgeInsets.only(top: 250),
                  child: Text(
                    "Let's get started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: db.toDoList1.length,
                    itemBuilder: (context, index) {
                      return ToDoTile(
                        taskName: db.toDoList1[index][0],
                        taskDescription: db.toDoList1[index][1],
                        taskCompleted: db.toDoList1[index][2],
                        onChanged: (value) => chekBoxChanged(value, index),
                        deleteFunction: (context) => deleteTask(index),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
