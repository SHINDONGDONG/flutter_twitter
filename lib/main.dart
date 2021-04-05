import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/FeedScreen.dart';
import 'Screens/WelcomeScreen.dart';

void main() async {

  //Firebase 코어를 사용하려면 선언해줘야함.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget getScreenId(){
    //Streambuilder  데이터의 흐름
    //스트림으로 부터 흘러나오는 이벤트를 감지하여 새로운 이벤트가 발생하면 다시 빌드함

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot) {
          if (snapshot.hasData) {
            //파이어베이스 어뜨 스테이트가 체인지되면 거기에 스냅샷 데이터가 있으면 피드스크린으로 이동
            return FeedScreen();
          } else {
            return WelcomeScreen();
          }
        }
          );}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: getScreenId(),
    );
  }
}


