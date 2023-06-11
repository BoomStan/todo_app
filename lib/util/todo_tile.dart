import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteToDo;

  const ToDoTile({super.key, 
  required this.taskName,
  required this.taskCompleted,
  required this.onChanged,
  required this.deleteToDo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0, top: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: deleteToDo,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
              )
          ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted, 
                onChanged: onChanged,
                activeColor: Colors.black,
                ),
              Text(taskName,
              style: TextStyle(fontSize: 20, decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none),),
            ],
          ),
        ),
      ),
    );
  }
}