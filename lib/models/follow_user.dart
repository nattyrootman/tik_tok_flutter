import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class Followers {


  String  userName;
  String userPhoto;
  int likes;
  int followers;
  int  following=0;
  bool isFollowing;
    List videourl;

     Followers({
       required this.userName,
       required this.userPhoto,
       required this.likes,
       required this.followers,
       required this.following,
       required this.isFollowing,
       required this.videourl
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userPhoto': userPhoto,
      'likes': likes,
      'followers': followers,
      'following': following,
      'isFollowing': isFollowing,
       'videourl' :videourl
    };
  }

  static  Followers fromMap( DocumentSnapshot doc) {

    var snapshots=doc.data() as Map<String,dynamic>;
   return Followers(
      userName: snapshots['userName'],
      userPhoto: snapshots['userPhoto']??"no photo",
      likes: snapshots['likes']?? [],
      followers: snapshots['followers']??0,
      following: snapshots['following']??0,
      isFollowing: snapshots['isFollowing']??false,
      videourl: snapshots['videourl']??[]
    
       
      );
   
  }



}
