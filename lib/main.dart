import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/WelcomeScreen.dart';
import 'package:flutter_chat_app/Constants.dart';
import 'package:flutter_chat_app/screens/LoginScreen.dart';
import 'package:flutter_chat_app/screens/RegisterScreen.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            body1: TextStyle(
              color: Colors. black54,
            ),
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          LoginScreen.id: (context) => LoginScreen(),
        });
  }
}
