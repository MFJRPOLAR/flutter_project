import 'package:flutter/material.dart';
import 'package:flutter_testing/components/dialog_box.dart';
import 'package:flutter_testing/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // first time opening app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.reminders[index][1] = !db.reminders[index][1];
    });
    db.updateDataBase();
  }

  // SAVE TASK
  void saveNewTask() {
    setState(() {
      db.reminders.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.reminders.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text(
          'My Reminders',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.account_circle_rounded),
        actions: [Icon(Icons.more_vert)],
        centerTitle: true,
        elevation: 15,
        shadowColor: Colors.orangeAccent,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.brown,
          onPressed: createNewTask,
          label: const Text("Add Reminder",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          )),
      body: ListView.builder(
        itemCount: db.reminders.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.reminders[index][0],
            taskCompleted: db.reminders[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
