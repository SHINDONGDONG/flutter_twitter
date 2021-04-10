import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter/Models/UserModel.dart';
import 'package:flutter_twitter/Service/DatabaseServicese.dart';
import 'package:flutter_twitter/Constatns/constants.dart';
import 'package:flutter_twitter/Service/auth_service.dart';
import 'package:get/get.dart';

import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const ProfileScreen({Key key, this.currentUserId, this.visitedUserId})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _followersCount = 0;
  int _followingCount = 0;

  //세그멘트 컨트롤 밸류를 지정해주고
  int _profileSegmentedValue = 0;
  //맵 형식으로 프로파일 세그멘트밸류를 키갑스로 받고 위젯으로 밸류를 돌려준다
  Map<int,Widget> _profileTabs = {
    0:Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
    child : Text(
      'Tweets',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Colors.white
      ),
    ),
    ),
    1:Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child : Text(
        'Media',
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
      ),
    ),
    2:Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child : Text(
        'Likes',
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
      ),
    ),
  };


  //cupertinosegment 탭바가 눌리면 이동할 탭페이지임
 Widget buildProfileWidgets(){
   switch(_profileSegmentedValue){
     case 0 :
       return Center(child: Text('Tweeters', style: TextStyle(fontSize: 25),),);
       break;
     case 1 :
       return Center(child: Text('Media', style: TextStyle(fontSize: 25),),);
       break;
     case 2 :
       return Center(child: Text('Likes', style: TextStyle(fontSize: 25),),);
       break;
     default :
       return Center(child: Text('Somthing wrong', style: TextStyle(fontSize: 25),),);
       break;
   }
 }

  //팔로워수 카운트하는 메소드
  getFollowersCount() async {
    int followersCount =
        await DatabaseServicese.followersNum(widget.visitedUserId);
    //mounted란 dispose등의 상태관리가 끝난경우 false가 된다. 살아있는경우 true
    if (mounted) {
      setState(() {
        //데이터베이스의 followers의 비짓유저아이디를 followersccunt에 넣는다.
        _followersCount = followersCount;
      });
    }
  }

  //팔로잉수 카운트하는 메소드
  getFollowingCount() async {
    int followingCount =
        await DatabaseServicese.followingNum(widget.visitedUserId);
    //mounted란 dispose등의 상태관리가 끝난경우 false가 된다. 살아있는경우 true
    if (mounted) {
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
          future: usersRef.doc(widget.visitedUserId).get(), //비동기식 코드,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //snapshot이 없을경우에는
            if (!snapshot.hasData) {
              print("Snapshot : ${usersRef.doc(widget.visitedUserId).get()}");
              print("data : ${snapshot.data.data()}");
              return Center(
                child: CircularProgressIndicator(
                  //돌아가는 컬러가
                  valueColor: AlwaysStoppedAnimation(kTweeterColor),
                ),
              );
            } else {
              //스냅샷 데이터가 있으면 UserModel에 Usermodel에 스냅샷 데이터를 넣는다.
              UserModel userModel = UserModel.fromDoc(snapshot.data);
              return ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: kTweeterColor,
                      image: userModel.coverimage.isEmpty
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(userModel.coverimage)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox.shrink(),
                          PopupMenuButton(
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 30,
                            ),
                            itemBuilder: (_) {
                              //리턴을 팝업메뉴 아이템으로 리턴하고 제네릭을 스트링으로 선언해주어 child,vlaue 에서
                              //텍스트와 벨류를 선언해준다.
                              return <PopupMenuItem<String>>[
                                new PopupMenuItem(
                                  child: Text('Logout'),
                                  value: 'logout',
                                )
                              ];
                            },
                            //선택이 되어있으면 선택된아이템을 selectedItem에 넣는다
                            onSelected: (selectedItem) {
                              if(selectedItem == 'logout'){
                                return AuthService.signOut();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //스택은 아니지만 스택처럼 보일 수 있게 매트릭스4 트랜스 밸류로 위치를 지정가능함
                    // 왼 아래위 오른쪽임
                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //서클아바타에 userModel.profilePicture에 데이터가 있으면 가지고오고 없으면 기본이미지를 출력
                            CircleAvatar(radius: 45,
                            backgroundImage: userModel.profilePicture.isEmpty ?
                              AssetImage('assets/placeholder.png') :
                                NetworkImage(userModel.profilePicture)
                              ,),
                            GestureDetector(
                              onTap: () {
                                Get.to(EditProfileScreen(user: userModel,));
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xff00acee)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xff00acee),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          userModel.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          userModel.bio,
                          style: TextStyle(
                              fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text('$_followingCount Following',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2 //레터 스페이싱이란 텍스트 한글자한글자 마다의 간격
                            ),
                            ),
                        SizedBox(width: 20,),
                            Text('$_followersCount Followers',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2 //레터 스페이싱이란 텍스트 한글자한글자 마다의 간격
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          //쿠퍼티노 세그멘트 컨트롤 ( 세그멘트를 컨트롤해주는 위젯)
                          child: CupertinoSlidingSegmentedControl(
                            //그룹을 묶어주어 한 그룹에있는 것들을 컨트롤할 수 있게 만들어준다
                            groupValue: _profileSegmentedValue,
                            thumbColor: Color(0xff00acee),
                            backgroundColor: Colors.blueGrey,
                            children: _profileTabs,
                            //onvaluechanged 눌리면 제어가가능
                            onValueChanged: (i) {
                              setState(() {
                                _profileSegmentedValue = i;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        buildProfileWidgets(),
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
