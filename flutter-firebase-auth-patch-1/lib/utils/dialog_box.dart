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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      backgroundColor: whiteColor,
      content: Container(
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: mainTitle,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: 'Add Title Tasks',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionTitle,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (mainTitle.text.isNotEmpty &&
                        descriptionTitle.text.isNotEmpty) {
                      return onSave();
                    } else {}
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
