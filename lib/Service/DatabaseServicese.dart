import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_twitter/Constatns/constants.dart';

class DatabaseServicese {
  static Future<int> followersNum(String userId) async {
    //쿼리문선언
    //followersSnapshot에                  //followersRef 는 팔로잉 콜렉션을 담고있다 그중 userid를 찾아 겟한다
    QuerySnapshot followersSnapshot =
      await followersRef.doc(userId).collection("userFollowers").get();
    return followersSnapshot.docs.length; //팔로잉 스냅샷 독 랭쓰를 (레코드수) 리턴
  }

  static Future<int> followingNum(String userId) async {
    //쿼리문선언
    //followersSnapshot에                  //followersRef 는 팔로잉 콜렉션을 담고있다 그중 userid를 찾아 겟한다
    QuerySnapshot followingSnapshot =
      await followingRef.doc(userId).collection("userFollowing").get();
    return followingSnapshot.docs.length; //팔로잉 스냅샷 독 랭쓰를 (레코드수) 리턴
  }
}