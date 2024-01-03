
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/models/user_model.dart';

class SearchingController extends  GetxController{

     
   Rx<List<UserModel>>searchingUser=Rx<List<UserModel>>([]);

     
  List<UserModel>get FindingUser =>searchingUser.value;



 getUser(String type){

 List<UserModel>listUser=[];
   searchingUser.bindStream(
     
     fireStore.collection("users").where("userName",isGreaterThanOrEqualTo: type)
     .snapshots().map((snapsDoc){
       snapsDoc.docs.forEach((element) { 
        listUser.add(UserModel.fromJson(element));
       });
       
        return listUser;
     })


   );

    }
}

