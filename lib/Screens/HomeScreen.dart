import 'package:flutter/material.dart';

import 'CreateTweeteScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //홈에서만 나올 수 있도록 플롵ㅇ 액션버튼을 여기로 옮겨줌.
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Image.asset("assets/tweet.png"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTweeteScreen(),
              ),
            );
          },
        ),
        body: Center(child: Text('Home')),
      ),
    );
  }
}
