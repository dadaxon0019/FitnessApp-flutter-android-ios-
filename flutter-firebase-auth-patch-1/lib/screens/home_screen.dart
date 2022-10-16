import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/card_widget_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/texts/app_medium_text.dart';
import '../utils/texts/app_small_text.dart';
import '../widgets/workout_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    // getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Color(0xff1C1C1E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Good Morning! ',
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 20, color: Colors.grey)),
                          ),
                          TextSpan(
                            text: '👋',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ])),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          id.email!,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: AssetImage('assets/avatar.jpg'),
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppMeddiumText(text: 'Today Workout Plan'),
                    AppSmallText(text: 'Mon 26 Apr', color: Color(0xffD0FD3E)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CardWidget(),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppMeddiumText(text: 'Workout Categories'),
                    AppSmallText(text: 'See All', color: Color(0xffD0FD3E))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                WorkoutCategories(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
