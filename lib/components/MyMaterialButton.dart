import 'package:flutter/material.dart';

class MyMaterialButton extends StatelessWidget {
  final String mButtonText;

  MyMaterialButton({this.mButtonText, this.mButtonPressed});

  Function mButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(32),
      color: Colors.blueAccent,
      elevation: 7,
      child: MaterialButton(
        onPressed: mButtonPressed,
        child: Text(
          mButtonText,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}