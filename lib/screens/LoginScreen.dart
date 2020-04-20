import 'package:flutter/material.dart';
import 'package:flutter_chat_app/components/MyMaterialButton.dart';
import 'package:flutter_chat_app/Constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  /*RegisterScreen(this.mScreenId);
  screenId mScreenId;*/
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: HERO_TAG,
                child: Image.asset(
                  "images/logo.png",
                  height: 200,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration:kTextFieldDecoration.copyWith(hintText: "Enter Your Email"),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: kTextFieldDecoration.copyWith(hintText: "Enter Your Password"),
              ),
              SizedBox(
                height: 50,
              ),
              MyMaterialButton(mButtonText: "Login",mButtonPressed:  () {},)
            ],
          ),
        ),
      ),
    );
  }
}


