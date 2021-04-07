import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/src/flutterwork/flutter_twitter/lib/Constatns/constants.dart';
import 'CreateTweeteScreen.dart';
import 'HomeScreen.dart';
import 'NotificationsScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;

  const FeedScreen({Key key, this.currentUserId,}) : super(key: key);
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  //선택한 탭의 번호
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //리스트의 엘리먼트 at 인덱스를 고를수이:ㅆ음 *****************
      body: [
        HomeScreen(),
        SearchScreen(),
        NotificationsScreen(),
        ProfileScreen(
          //프로필 스크린에 당연히 커런트아이디는 커런트ID,
          //방문 userid도 커런트 id
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
      ].elementAt(_selectedTab),
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
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        //액티브컬러
        activeColor: kTweeterColor,
        currentIndex: _selectedTab, //꼭 지정해줘야 탭바가움직임
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none)),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp)),
        ],
      ),
    );
  }
}
