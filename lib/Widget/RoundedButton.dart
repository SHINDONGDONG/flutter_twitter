import 'package:flutter/material.dart';
import 'package:flutter_twitter/Constatns/constants.dart';

class RoundedButton extends StatelessWidget {
  final String btnText;
  final Function onBtnPressed;

  RoundedButton({this.btnText, this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: kTweeterColor,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: onBtnPressed,
        minWidth: 300,
        height: 60,
        child: Text(
          btnText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
