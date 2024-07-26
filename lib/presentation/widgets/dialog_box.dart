import 'package:flutter/material.dart';
import 'package:nfc_app/presentation/widgets/custom_button.dart';

class DialogBox extends StatefulWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});
  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Text goes in here ",
              ),
            ),
            //buttons => Save + Cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                  buttonName: "Save",
                  onTap: widget.onSave,
                ),
                MyButton(
                  buttonName: "Cancel",
                  onTap: widget.onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
