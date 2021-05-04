import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter/Constatns/constants.dart';
import 'package:flutter_twitter/Models/UserModel.dart';
import 'package:flutter_twitter/Screens/ProfileScreen.dart';
import 'package:flutter_twitter/Service/DatabaseServicese.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  final String currentUserId; //검색할 때 현재의 아이디가 접속되어있는걸 확인

  const SearchScreen({Key key, this.currentUserId}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot> _users; //검색될 유저들을 QuerySanpshot 제네릭타입으로 선언
  TextEditingController _searchController = TextEditingController();

  clearSearch(){
    //위젯바인딩 서치컨트롤러를 클리어하고 setstate로 users를 null로 초기화시켜준다.
    WidgetsBinding.instance.addPersistentFrameCallback((_)=>_searchController.clear());
    setState(() {
      _users = null;
    });
  }

  buildUserList(UserModel user){
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: user.profilePicture.isEmpty?
        AssetImage("assets/placeholder.png"):
        NetworkImage(user.profilePicture),
      ),
      title: Text(user.name),
      onTap: (){
        Get.to(ProfileScreen(currentUserId: widget.currentUserId,visitedUserId: user.id,));

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              hintText: 'Search Twitter...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search,color: Colors.white,),
              suffixIcon: IconButton(icon : Icon(Icons.clear,color: Colors.white,),
                onPressed: (){
                  clearSearch();
                },
              ),
              filled: true,
            ),
            onChanged: (input) {
              if(input.isNotEmpty){
                setState(() {
                  _users=DatabaseServicese.searchUsers(input);
                });
              }
            },
          ),
        ),
        body: _users == null ?
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search,size: 200,),
                  Text('Search Twitter.....',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ],
              ),
            ):
            FutureBuilder(
              future: _users,
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.data.docs.length==0){
                  return Center(
                    child: Text('No Users found!'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    UserModel user = UserModel.fromDoc(snapshot.data.docs[index]);
                    return buildUserList(user);
                  }
                );
              }
            )
      ),
    );
  }
}
