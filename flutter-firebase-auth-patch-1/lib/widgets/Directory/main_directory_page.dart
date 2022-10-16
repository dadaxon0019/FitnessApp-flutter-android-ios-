import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/texts/app_large_text.dart';
import 'exercise.dart';

class DirectoryPage extends StatefulWidget {
  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  List directoryInfo = [];
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/directory.json')
        .then((value) => {
              setState((() {
                directoryInfo = json.decode(value);
              }))
            });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _onMovieTap(int index) {
    final id = directoryInfo[index].id;
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => Exercise()));
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Справчник'),
          centerTitle: true,
          toolbarHeight: 20,
          backgroundColor: mainColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: directoryInfo.length,
          itemBuilder: (_, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Exercise()));
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
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 25),
          height: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(directoryInfo[index]['imgUrl']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 125,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              gradientFirstColor,
              transparentColor,
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppLargeText(
                text: directoryInfo[index]['title'],
                size: 18,
              )
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Container(
              height: 125,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => Exercise()));
                },
              )),
        ),
      ],
    );
  }
}
