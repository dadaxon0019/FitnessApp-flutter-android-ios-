import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSmallText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppSmallText({this.size = 14, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
