
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/models/follow_user.dart';

import '../models/video_model.dart';

class     ControllerProfile extends     GetxController{


    Rx<Followers> _userFollowers=Rx<Followers>(Followers(userName:"", userPhoto:"", likes: 0, followers: 0, following: 0, isFollowing: false, videourl: []));

   Followers get userFollowers=>_userFollowers!.value;

   Rx<String>_uid=''.obs;


     

    
   UpDateProfile(String id){

    _uid.value=id;
    getUserProfile();
   }

     
     
   getUserProfile()async{
     
     List<Followers>allFollowers=[];
         
      var  Videodoc=await fireStore.collection("videos")
      .where("uid",isEqualTo: _uid.value).get();

      for (var i = 0; i < Videodoc.docs.length; i++) {

        allFollowers.add((Videodoc.docs[i] as dynamic)["'videourl"]);
        
      }
     

      
      int likes=0;
     int followers=0;
     int following=0;
     bool isFollowing=false;

      var followersDoc= await fireStore.collection("users").doc(_uid.value).collection("followers").get();

      var followinDoc= await fireStore.collection("users").doc(_uid.value).collection("followers").get();

      DocumentSnapshot userDoc=await fireStore.collection("userss").doc(_uid.value).get();

       followers=followersDoc.docs.length;
       following=followinDoc.docs.length;

       for (var i  in  Videodoc.docs) {

           likes+=(i.data()["likes"] as List).length;
         
       }
    

       fireStore.collection("users").doc(_uid.value).collection("followers").doc(authController.user.uid).get()
      .then((value) {
        if(value.exists){
         isFollowing=true;
        }else{
          isFollowing=false;
        }

      });

       
   
   _userFollowers.value =Followers(
        userName: (userDoc.data()! as Map<String, dynamic>)["userName"], 
        userPhoto: (userDoc.data()!as Map<String, dynamic>)["userPhoto"], 
        likes: likes, followers: followers,
         following: following, 
         isFollowing: isFollowing, 
         videourl: allFollowers);
     
    update();
       
   }
   
   folloMe()async{

    try{
      DocumentSnapshot doc = await fireStore.collection("users").doc(_uid.value)
    .collection("followers").doc(authController.user.uid).get();

    if(!doc.exists){

      await fireStore.collection("users").doc(_uid.value)
      
      .collection("followers").doc(authController.user.uid).set(_userFollowers.value.toJson());

       await fireStore.collection("users").doc(authController.user.uid)
       .collection("following").doc(_uid.value).set(_userFollowers.value.toJson());

      _userFollowers.update(( Followers ?val) =>(val!.followers+1).toString());
    }else{

       await fireStore.collection("users").doc(_uid.value)
       .collection("followers").doc(authController.user.uid).delete();

       await fireStore
       .collection("users").doc(authController.user.uid)
       .collection("following").doc(_uid.value).delete();

       _userFollowers.update(( Followers ? val) =>(val!.following-1).toString());
            
            _userFollowers.update((  Followers ? val) =>val!.isFollowing=!val.isFollowing);
            update();

    }



    }on FirebaseException catch(e){

        print(e.message);
    }catch(e){
      print(e.toString());
    }


    }

   



   }
   



