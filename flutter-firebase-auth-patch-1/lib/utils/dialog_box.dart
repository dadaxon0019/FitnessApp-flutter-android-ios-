import 'dart:math';

import 'package:firebase_auth_demo/utils/constants/colors.dart';
import 'package:firebase_auth_demo/utils/my_button.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final mainTitle;
  final descriptionTitle;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {Key? key,
      required this.onSave,
      required this.onCancel,
      required this.mainTitle,
      required this.descriptionTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 219, 219, 219),
      content: Container(
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: mainTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Title Tasks',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Description Tasks',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(
                    text: 'Save',
                    onPressed: () {
                      if (mainTitle.text.isNotEmpty &&
                          descriptionTitle.text.isNotEmpty) {
                        return onSave();
                      } else {}
                    }),
                SizedBox(
                  width: 8,
                ),
                //cancel button
                MyButton(text: 'Cancel', onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
