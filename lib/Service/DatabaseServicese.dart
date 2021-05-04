import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_twitter/Constatns/constants.dart';
import 'package:flutter_twitter/Models/UserModel.dart';

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

  //updateUserdata 업데이트함
  static void updateUserData(UserModel userModel) {
    usersRef.doc(userModel.id).update({
      'name': userModel.name,
      'bio': userModel.bio,
      'profilePicture': userModel.profilePicture,
      'coverimage': userModel.coverimage,
    });
  }

  //search 문자를 받아 회원찾기
  static Future<QuerySnapshot> searchUsers(String name) async {
    Future<QuerySnapshot> users = usersRef.where(
        'name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: name + 'z').get();

    return users;
  }

  static void followUser(String currentUserId, String visitUserId) {
    followingRef
        .doc(currentUserId)
        .collection('Following')
        .doc(visitUserId)
        .set({});
    followingRef
        .doc(visitUserId)
        .collection('Followers')
        .doc(currentUserId)
        .set({});
  }

  static void unFollowUser(String currentUserId, String visitUserId) {
    followingRef
        .doc(currentUserId)
        .collection('Following')
        .doc(visitUserId)
        .get()
        .then((doc) {
      if (doc.exists){
        doc.reference.delete();
      }
    });

    followingRef
        .doc(visitUserId)
        .collection('Followers')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists){
        doc.reference.delete();
      }
    });
  }

  static Future<bool> isFollowingUser(String currentUserId,String visitedUserId) async {
    DocumentSnapshot followingDoc = await followersRef.doc(visitedUserId).collection('Followers').doc(currentUserId).get();
    return followingDoc.exists;
  }


}