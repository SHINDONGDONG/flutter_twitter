import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_twitter/Constatns/constants.dart';
import 'package:flutter_twitter/Models/UserModel.dart';
import 'package:flutter_twitter/Service/DatabaseServicese.dart';
import 'package:flutter_twitter/Service/StorageService.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  String _name;
  String _bio;
  File _profileImage;
  File _coverImage;
  String _imagePickedType;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  displayCoverImage() {
    if (_coverImage == null) {
      if (widget.user.coverimage.isNotEmpty) {
        return NetworkImage(widget.user.coverimage);
      }
    } else {
      return FileImage(_coverImage);
    }
  }

  displayProfileImage() {
    //이미지 파일이 없으면
    if (_profileImage == null) {
      //파이어베이스에 프로필 사진이 없으면
      if (widget.user.profilePicture.isEmpty) {
        //기본이미지를 리턴
        return AssetImage("assets/placeholder.png");
      } else {
        //아니면 네트워크 이미지로 프로파일이미지를 불러온다.
        return NetworkImage(widget.user.profilePicture);
      }
    } else {
      return FileImage(_profileImage);
    }
  }

  saveProfile() async {
    print('Save button 누름');
    _formKey.currentState.save(); //formkey 스테이트를 세이브한다.
    if (_formKey.currentState.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
        print(_isLoading);
      });
      String profilePictureUrl = '';
      String coverPictureUrl = '';
      if (_profileImage == null) {
        profilePictureUrl = widget.user.profilePicture;
      } else {
        profilePictureUrl = await StorageService.uploadProfilePicture(
            widget.user.profilePicture, _profileImage
        );
        if (_coverImage == null) {
          coverPictureUrl = widget.user.coverimage;
        } else {
          coverPictureUrl = await StorageService.uploadCoverPicture(
              widget.user.coverimage, _coverImage
          );
        }
        UserModel user = UserModel(
            id: widget.user.id,
            name: _name,
            profilePicture: profilePictureUrl,
            bio: _bio,
            coverimage: coverPictureUrl
        );

        DatabaseServicese.updateUserData(user);
        Navigator.pop(context);
      }
    }
  }

    Future handleImageFormGallery() async {
      try {
        //PickedFile에 이미지파일 이미지 핔커 겟 이미지 소스는 카메라인지 갤러리인지 고를 수 있음.
        PickedFile imageFile = await ImagePicker().getImage(
            source: ImageSource.gallery);
        if (imageFile != null) {
          if (_imagePickedType == 'profile') {
            setState(() {
              _profileImage = File(imageFile.path);
            });
          } else if (_imagePickedType == 'cover') {
            setState(() {
              _coverImage = File(imageFile.path);
            });
          }
        }
      } catch (e) {
        print('error!!! :' + e);
      }
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _name = widget.user.name;
      _bio = widget.user.bio;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ListView(
          physics: BouncingScrollPhysics(
              parent: const AlwaysScrollableScrollPhysics()
          ),
          children: [
            GestureDetector(
              onTap: () {
                _imagePickedType = 'cover';
                handleImageFormGallery();
              },
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: kTweeterColor,
                        image: _coverImage != null ?
                        DecorationImage(
                            fit: BoxFit.cover,
                            image: displayCoverImage()
                        ) :
                        null
                    ),
                  ),
                  Container(
                    height: 150,
                    color: Colors.black54,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt,
                          size: 70,
                          color: Colors.white,
                        ),
                        Text(
                          'Change Cover Photo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              transform: Matrix4.translationValues(0, -40, 0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //서클아바타에 userModel.profilePicture에 데이터가 있으면 가지고오고 없으면 기본이미지를 출력
                      GestureDetector(
                        onTap: () {
                          _imagePickedType = 'profile';
                          handleImageFormGallery();
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(radius: 45,
                                backgroundImage: displayProfileImage()),
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.black54,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Change Cover Photo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        // onTap: saveProfile(),
                        child: Container(
                          height: 35,
                          width: 100,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: kTweeterColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kTweeterColor),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey, //폼 데이터를 전송하기위한 키
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        TextFormField(
                          initialValue: _name,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: kTweeterColor),
                          ),
                          validator: (input) =>
                          input
                              .trim()
                              .length < 2 ?
                          'please enter vaild name'
                              : null,
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          initialValue: _bio,
                          decoration: InputDecoration(
                            labelText: 'bio',
                            labelStyle: TextStyle(color: kTweeterColor),
                          ),
                          validator: (input) =>
                          input
                              .trim()
                              .length < 2 ?
                          'please enter vaild bio'
                              : null,
                          onSaved: (value) {
                            _bio = value;
                          },
                        ),
                        _isLoading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(kTweeterColor),
                        ) : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }