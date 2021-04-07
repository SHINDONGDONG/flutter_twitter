import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter/Models/UserModel.dart';
import 'package:flutter_twitter/Service/DatabaseServicese.dart';
import 'file:///C:/src/flutterwork/flutter_twitter/lib/Constatns/constants.dart';

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

  // DocumentSnapshot doc = await usersRef.doc(u.uid).get();
  // Map _docdata = doc.data();
  // newUserrr = Userr.fromDocument(doc, _docdata);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: usersRef.doc(widget.visitedUserId).get(),//비동기식 코드,
          builder: (BuildContext context,AsyncSnapshot snapshot){
            //snapshot이 없을경우에는
            if(!snapshot.hasData){
              print("Snapshot : ${usersRef.doc(widget.visitedUserId).get()}");
              print("data : ${snapshot.data.data()}");
              return Center(
                child: CircularProgressIndicator(
                  //돌아가는 컬러가
                  valueColor: AlwaysStoppedAnimation(kTweeterColor),
                ),
              );
            }else{
              //스냅샷 데이터가 있으면 UserModel에 Usermodel에 스냅샷 데이터를 넣는다.
              UserModel userModel = UserModel.fromDoc(snapshot.data);
              print("usermodel : ${userModel}");
              return ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: kTweeterColor,
                      image: userModel.coverImage == null
                          ? null
                          : DecorationImage(fit: BoxFit.cover,
                          image: NetworkImage(userModel.coverImage)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox.shrink(),
                        PopupMenuButton(
                          icon: Icon(Icons.more_horiz,color: Colors.white,size: 30,),
                          itemBuilder: (context) {
                            return <PopupMenuItem<String>>[
                              new PopupMenuItem(child: Text('Logout'),value: 'logout',)
                            ];
                          },)
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      );
  }
}
