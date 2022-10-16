import 'dart:convert';
import 'package:firebase_auth_demo/widgets/Directory/exercise_info.dart';
import 'package:firebase_auth_demo/widgets/Directory/info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/texts/app_large_text.dart';

class Exercise extends StatefulWidget {
  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  List exerciseInfo = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/exercise.json')
        .then((value) => {
              setState((() {
                exerciseInfo = json.decode(value);
              }))
            });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Упражнения'),
          centerTitle: true,
          toolbarHeight: 50,
          backgroundColor: mainColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: exerciseInfo.length,
          itemBuilder: (_, int index) {
            DescriptionInfo info = infoList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => InfoInfo(info),
                  ),
                );
                debugPrint(index.toString());
                setState(() {});
              },
              child: _buildCard(index),
            );
          },
        ),
      ),
    );
  }

  _buildCard(int index) {
    return Container(
      height: 85,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(135, 255, 255, 255)),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(exerciseInfo[index]['imgUrl']),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          AppLargeText(
            text: exerciseInfo[index]['title'],
            size: 17,
          ),
          Expanded(
            child: Container(),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: whiteColor,
            ),
          )
        ],
      ),
    );
  }
}
