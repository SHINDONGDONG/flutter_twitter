import 'package:flutter/material.dart';
import 'package:flutter_twitter/Service/auth_service.dart';
import 'package:flutter_twitter/Widget/RoundedButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  bool passview = false;

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
              obscureText: passview ? false : true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: passview ?
                  Icon(Icons.visibility_off_rounded):
                  Icon(Icons.remove_red_eye_sharp),
                onPressed: (){
                    setState(() {
                  passview = !passview;
                    });
                },),
                hintText: 'Enter your Password',
              ),
              onChanged: (value){
                _password = value;
              },
            ),
            SizedBox(height: 40,),

            RoundedButton(btnText: 'LOG IN',
              onBtnPressed: ()async{
                //Auth 서비스
                //들어온 네임 이메일 패스워드가 없으면
                //이메일 패스워드를 검증하여 로그인한다
                bool isValid = await AuthService.login(_email, _password);
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
