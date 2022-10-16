import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppMeddiumText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppMeddiumText(
      {this.size = 17, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
