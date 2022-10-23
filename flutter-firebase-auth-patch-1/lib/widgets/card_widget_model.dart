import 'package:firebase_auth_demo/widgets/To%20Do/to_do_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/texts/app_medium_text.dart';
import '../utils/texts/app_small_text.dart';

class Card {
  final Image img;
  final String mainText;
  final String subTitle;

  Card({
    required this.img,
    required this.mainText,
    required this.subTitle,
  });
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('img/cardimg1.png'),
                fit: BoxFit.cover,
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => ToDoScreen()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Color.fromARGB(35, 62, 59, 59),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppMeddiumText(text: 'Day 01 - Warm Up'),
                SizedBox(
                  height: 5,
                ),
                AppSmallText(
                  text: '07:00 - 08:00 AM',
                  color: const Color(0xffD0FD3E),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
