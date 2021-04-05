import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/WelcomeScreen.dart';

void main() async {

  //Firebase 코어를 사용하려면 선언해줘야함.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}


