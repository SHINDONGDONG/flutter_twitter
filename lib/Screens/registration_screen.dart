import 'package:flutter/material.dart';
import 'package:flutter_twitter/Service/auth_service.dart';
import 'package:flutter_twitter/Widget/RoundedButton.dart';
import 'file:///C:/src/flutterwork/flutter_twitter/lib/Constatns/constants.dart';

class RegistationScreen extends StatefulWidget {
  @override
  _RegistationScreenState createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  String _email;
  String _password;
  String _name;
  bool passview = false;

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
              obscureText: passview ? true : false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon : passview ? Icon(Icons.no_cell) :
                  Icon(Icons.remove_red_eye_sharp),
                  onPressed: (){
                  passview = !passview;
                },),
                hintText: 'Enter your Password',
              ),
              onChanged: (value){
                _password = value;
              },
            ),
            SizedBox(height: 40,),

            RoundedButton(btnText: 'Create account',
              onBtnPressed: ()async{
                //Auth 서비스
                //들어온 네임 이메일 패스워드가 없으면
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
