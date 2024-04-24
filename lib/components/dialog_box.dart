import 'package:flutter/material.dart';
import 'package:flutter_testing/components/my_button.dart';

final _formkey = GlobalKey<FormState>();

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepOrangeAccent,
      content: SizedBox(
        height: 150,
        child: Form(
          key: _formkey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // user input
                TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Reminder',
                  ),
                  validator: (note) =>
                      note!.isEmpty ? 'Invalid Input For Reminder' : null,
                ),

                //buttons = > save + cancel
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // save
                    MyButton(
                        text: 'Save',
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            onSave();
                          } else {
                            _formkey.currentState!.validate();
                          }
                        }),

                    const SizedBox(width: 4),

                    // cancel
                    MyButton(text: "Cancel", onPressed: onCancel),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
