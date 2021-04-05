import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  static final _auth = FirebaseAuth.instance;  //firebase 의 인스턴스를 만들어줘야함!
  static final _firestore = FirebaseFirestore.instance; //파이어 스토어( 데이터베이스 관한것)


   //로그인 퓨처 메소드를 만들어준다.
  static Future<bool> signUp(String name,String email,String password)async{
    try{
      //UserCred 클래스에      _auth (firebaseauth관련 createUsertithEmailandPassword 인스턴스를 불러완다!!)
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //User 클래스에 authResult의 user를 넣음
      User signedInUser = authResult.user;

      //signInUser 에 아무것도 없으면 _fireStore에 콜렉션 추가 users 테이블에 doc.signedInUser.uid  셋함
      if(signedInUser != null){
        _firestore.collection("users").doc(signedInUser.uid).set(
          {
            'name' : name,
            'email' : email,
            'profilePicture':'',
            'coverimage' : '',
            'bio' : '',
            
            //커버이미지와 bio를 추가
          }
        );
        return true;
      }
      return false;

    }catch(e){
      print(e);
      return false;
    }
  }

  static Future<bool> login(String email,String password)async{
    try{
      //firebase 어뜨 인스턴스에서 사인우시 이메일 맨드 패스워드로 인증하기
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true; //성공시 리턴 트루를 반환하여 로그인하기
    }catch(e){
      print(e);
      print("로그인에 문제");
      return false;
    }
  }


}