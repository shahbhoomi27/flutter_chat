import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_chat_app/screens/RegisterScreen.dart';
import 'package:flutter_chat_app/components/MyMaterialButton.dart';
import 'package:flutter_chat_app/Constants.dart';

import 'LoginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {

      });
      print(animation.value);
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: HERO_TAG,
                child: Image.asset(
                  "images/logo.png",
                  height: 60,
                ),
              ),
              TypewriterAnimatedTextKit(
                text:["Flash Chat"],
                textAlign: TextAlign.start,
                textStyle: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
          SizedBox(
            height: 48,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyMaterialButton(
              mButtonText: "Login",
              mButtonPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyMaterialButton(
              mButtonText: "Registration",
              mButtonPressed: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
