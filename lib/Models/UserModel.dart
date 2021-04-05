
//User model 을 만든다.
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String profilePicture;
  String email;
  String bio;
  String coverImage;

  UserModel(
      {this.id,
      this.name,
      this.profilePicture,
      this.email,
      this.bio,
      this.coverImage});

  //항상 클래스의 새 인스턴스를 생성하지는 않는 생성자를 구현할 때는 factory 키워드를 사용 바랍니다.
  //싱글톤 패턴
  factory UserModel.fromDoc(DocumentSnapshot doc){
    return UserModel(
      id:doc.id,
      name: doc['name'],
      email: doc['email'],
      profilePicture:doc['profilePicture'],
      bio: doc['bio'],
      coverImage: doc['coverImage'],
    );
  }

}

