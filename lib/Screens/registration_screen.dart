import 'package:flutter/material.dart';
import 'package:flutter_twitter/Service/auth_service.dart';
import 'package:flutter_twitter/Widget/RoundedButton.dart';
import 'package:flutter_twitter/Constatns/constants.dart';

class RegistationScreen extends StatefulWidget {
  @override
  _RegistationScreenState createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  String _email;
  String _password;
  String _name;
  bool _passview = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTweeterColor,
        centerTitle: true,
        elevation: 0,
        title: Text('Ragistaration',
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (value){
                _name = value;
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              onChanged: (value){
                _email = value;
              },
            ),
            SizedBox(height: 20,),
            TextField(
              obscureText: _passview ? false:true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _passview = !_passview;
                    });
                  },
                  icon: _passview ?
                    Icon(Icons.remove_red_eye):
                    Icon(Icons.visibility_off_rounded),
                ),
                hintText: 'Enter your Password',
              ),
              onChanged: (value){
                _password = value;
              },
            ),
            SizedBox(height: 40,),

            RoundedButton(btnText: 'Create account',
              onBtnPressed: ()async{
                //Auth ?????????
                //????????? ?????? ????????? ??????????????? ?????????
                bool isValid = await AuthService.signUp(_name, _email, _password);
                if(isValid){
                  Navigator.pop(context);
                }else{
                  print('sumthind');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
