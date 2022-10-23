import 'package:firebase_auth_demo/utils/constants/colors.dart';
import 'package:firebase_auth_demo/auth/services/Login-SignUp/signup_email_password_screen.dart';
import 'package:firebase_auth_demo/auth/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void loginUser() {
      context.read<FirebaseAuthMethods>().loginWithEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context,
          );
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              Container(
                width: w,
                height: h * 0.47,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/Rectangle 9.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(212, 255, 255, 255)),
                    ),
                    Text(
                      'Sign into your account',
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(
                              Icons.email,
                              color: primaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: whiteColor, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: primaryColor, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: primaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: whiteColor, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: primaryColor, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  loginUser();
                },
                child: Container(
                  width: w * 0.5,
                  height: h * 0.06,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(212, 208, 253, 62),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: mainColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, EmailPasswordSignup.routeName);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, bottom: 15),
                      width: w * 0.2,
                      height: 40,
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

 //CustomButton(
            //   onTap: () {
            //     Navigator.pushNamed(context, EmailPasswordLogin.routeName);
            //   },
            //   text: 'Email/Password Login',
            // ),
            // CustomButton(
            //   onTap: () {
            //     context.read<FirebaseAuthMethods>().signInWithGoogle(context);
            //   },
            //   text: 'Google Sign In',
            // ),