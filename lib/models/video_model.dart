import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';


class VideoModel {


  String userName;
  String uid;
  String id;
  
  List likes;
  int commentsCount;
  int shareCount;
  String songName;
   String caption;
   String userPhoto;
   String videourl;
   //String? thumbnail;
  VideoModel({
    required this.userName,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentsCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.userPhoto,
    required this.videourl,
   
  });
  
  List get listLike=>likes;
     
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentsCount': commentsCount,
      'shareCount': shareCount,
      'songName': songName,
      'caption': caption,
       'userPhoto':userPhoto,
      'videourl': videourl,
      
    };
  }

  static  VideoModel fromMap(DocumentSnapshot docs) {
    var snapshot=docs.data() as  Map<String, dynamic> ;

        

      return VideoModel(
      userName: snapshot['userName']??"userName",
      uid: snapshot['uid']??"uid",
      id: snapshot['id']??"id",
      likes: snapshot['likes'] ,
      commentsCount: snapshot['commentsCount']??0,
      shareCount: snapshot['shareCount']??0,
      songName: snapshot['songName']??"songName",
      caption: snapshot['caption']??"description",
      userPhoto: snapshot["userPhoto"]??"emptyPhotoUrl",
      videourl: snapshot['videourl']??"emptyVideoUrl"
      
      );
    
  }

  
}
