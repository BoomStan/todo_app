import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialogbox.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    } else{
      db.loadData();
    }
    super.initState();
  }


  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask(){
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _controller, 
        onSave:  saveNewTask, 
        onCancel: () => {
          Navigator.of(context).pop(),
          _controller.clear()
          });
    });
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 50, 50, 50),
          toolbarHeight: 100,
          elevation: 0,
          title: const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text('TO DO', style: TextStyle(fontSize: 30, color: Colors.white),),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
          ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteToDo: (context) => deleteTask(index),
                );
          },
        ));
  }
}
