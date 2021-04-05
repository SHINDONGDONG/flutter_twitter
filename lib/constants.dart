
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const kTweeterColor = Color(0xff00acee);

//파이어 스토어 (테이블 인스턴스를 선언)
final _fireStore = FirebaseFirestore.instance;

//users의 Ref 참조문서 (콜렉션 users 테이블 선언)
final usersRef = _fireStore.collection("users");


//팔로워의 정보를 담은 테이블
final followersRef = _fireStore.collection("followers");
//팔로잉 한 유저 정보를 담은 테이블
final followingsRef = _fireStore.collection("followings");
