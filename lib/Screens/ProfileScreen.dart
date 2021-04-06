import 'package:flutter/material.dart';
import 'package:flutter_twitter/Service/DatabaseServicese.dart';

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const ProfileScreen({Key key, this.currentUserId, this.visitedUserId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _followersCount = 0;
  int _followingCount = 0;

  //팔로워수 카운트하는 메소드
  getFollowersCount()async{
    int followersCount  = await DatabaseServicese.followersNum(widget.visitedUserId);
    //mounted란 dispose등의 상태관리가 끝난경우 false가 된다. 살아있는경우 true
    if(mounted){
      setState(() {
        //데이터베이스의 followers의 비짓유저아이디를 followersccunt에 넣는다.
        _followersCount = followersCount;
      });
    }
  }

  //팔로잉수 카운트하는 메소드
  getFollowingCount()async{
    int followingCount  = await DatabaseServicese.followingNum(widget.visitedUserId);
    //mounted란 dispose등의 상태관리가 끝난경우 false가 된다. 살아있는경우 true
    if(mounted){
      setState(() {
        //데이터베이스의 followers의 비짓유저아이디를 followersccunt에 넣는다.
        _followingCount = followingCount;
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initstate로 초기 실행시 1회 실행하게만듬.
    getFollowingCount();
    getFollowersCount();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Text('Profile')),
      ),
    );
  }
}
