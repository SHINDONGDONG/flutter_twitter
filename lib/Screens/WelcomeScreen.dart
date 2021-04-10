import 'package:flutter/material.dart';
import 'package:flutter_twitter/Widget/RoundedButton.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width,),
              Column(
                children: [
                  Image.asset("assets/logo.png",width: 200,height: 200,),
                  Text('어서오세요',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ],
              ),
              Column(
                children: [
                  RoundedButton(btnText:"LOG IN", onBtnPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context)=>LoginScreen()));
                  },),
                  SizedBox(height: 30,),
                  RoundedButton(btnText:"Create account", onBtnPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>RegistationScreen()));
                  },),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
