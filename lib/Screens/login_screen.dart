import 'package:flutter/material.dart';
import 'package:flutter_twitter/Widget/RoundedButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00acee),
        centerTitle: true,
        elevation: 0,
        title: Text('Log in',
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your Email',
              ),
              onChanged: (value){
                _email = value;
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your Password',
              ),
              onChanged: (value){
                _password = value;
              },
            ),
            SizedBox(height: 40,),

            RoundedButton(btnText: 'LOG IN',onBtnPressed: (){},),
          ],
        ),
      ),
    );
  }
}
