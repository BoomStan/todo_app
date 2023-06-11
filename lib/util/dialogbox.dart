import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;

  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 46, 46, 46),
      content: Container(
        height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: """Your Todo""",
                hintStyle: TextStyle(color: Color.fromARGB(255, 118, 118, 118))
                ),
            
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              MyButton(text: "Save", onPressed: onSave, ),
              const SizedBox(width: 20,),
              MyButton(text: "Cancel", onPressed: onCancel)
            ],)
          ],),
        ),
    );
  }
}