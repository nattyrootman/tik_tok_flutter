import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {


  String userName;
  String uid;
  String id;
  String comment;
  String datePublished;
  List likes;
  String userPhoto;
  
  Comments({
    required this.userName,
    required this.uid,
    required this.id,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.userPhoto
  });
 

  Map<String, dynamic> tojson() {
    return {
      'userName': userName,
      'uid': uid,
      'id': id,
      'comment': comment,
      "datePublished":datePublished,
      'likes': likes,
      'userPhoto': userPhoto,
    };
  }

  static  Comments fromMap( DocumentSnapshot  map) {
    var snapshot=map.data() as Map<String, dynamic>;
    
      return Comments(
      userName: snapshot!['userName'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      comment: snapshot['comment'],
      datePublished:snapshot["datePublished"],
      likes: snapshot['likes'],
      userPhoto: snapshot['userPhoto'],
      );
    
    }
  }
  

 



