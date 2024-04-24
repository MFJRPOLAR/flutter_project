import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List reminders = [];

  // reference our box
  final _mybox = Hive.box("mybox");

  void createInitialData() {
    reminders = [
      ["Watch Youtube", false],
      ["Play Games", false],
    ];
  }

  // load data
  void loadData() {
    reminders = _mybox.get("TODOLIST");
  }

  // update data
  void updateDataBase() {
    _mybox.put("TODOLIST", reminders);
  }
}
