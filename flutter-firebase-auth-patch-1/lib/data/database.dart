import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('myBox');

//run this method if this is the1st time ever openinig this app
  void creatInitialData() {
    toDoList = [
      ['Make tutorial', false],
      ['Do exercise', false],
    ];
  }

  //load Data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //updae the database
  void upDateBase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
