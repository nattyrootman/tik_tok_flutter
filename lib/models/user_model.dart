import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {


  String userName;
  String userEamail;
  String userPhoto;
  String uid;
  UserModel({  required this.userName,required this.userEamail, required this.userPhoto, required this. uid,});


  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEamail,
      'userPhoto': userPhoto,
      'uid':  uid,
    };
  }

  static  UserModel fromJson( DocumentSnapshot<Map<String, dynamic>> docs) {
   

   var map=docs.data();
      return UserModel(
      userName: map!['userName'],
      userEamail: map['userEmail'],
      userPhoto: map['userPhoto'],
       uid: map['uid']);
    
  }
}
 

  
