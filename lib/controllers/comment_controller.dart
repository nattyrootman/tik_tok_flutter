

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/controllers/videolist_controller.dart';
import 'package:hop_tock/models/comments.dart';

class CommentsController extends GetxController{



  Rx<List<Comments>>commentList=Rx<List<Comments>>([]);

  List<Comments>get  getCommentList=>commentList.value;

    String PostId1="";

   


      updateComment(String id){

      PostId1=id;
     getAllComment();
    }
   
  

  

     getAllComment()async{

       commentList.bindStream(


        fireStore.collection('videos')
          .doc(PostId1)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comments> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comments.fromMap(element));
               print(retValue);
          }
          return retValue;
        },
      ),



       );


       
    }  

        



  



  PostComment(String commentText)async{
     

    try {

      String uid=authController.user.uid;
    DocumentSnapshot userDoc=await fireStore.collection("users").doc(uid).get();
    var allDoc=await fireStore.collection("videos").doc(PostId1).collection("comments").get();
  

    if (commentText.isNotEmpty) {

       String comid=DateTime.now().millisecondsSinceEpoch.toString();
       
      Comments comments= Comments(
        userName: (userDoc.data()! as Map<String,dynamic>)["userName"], 
        uid:uid, 
        id: "${allDoc.docs.length}", 
        comment: commentText, 
        datePublished:DateTime.now().toString(),
        likes: [], 
        userPhoto: (userDoc.data()!as Map<String,dynamic>)["userPhoto"]) ;

        await fireStore.collection("videos").doc(PostId1).collection("comments").doc("${allDoc.docs.length}").set(comments.tojson())
        .whenComplete(() => print("Bravo files are loadedd"));

      DocumentSnapshot doc=   await fireStore.collection("videos").doc(PostId1).get();

        await fireStore.collection("videos").doc(PostId1).update({
          'commentsCount': (doc.data()!as Map<String , dynamic>)['commentsCount'] + 1 });


    }else{

       Get.snackbar("please", "field can not be empty ");
       print("id ne peut pas etre null");
    }


      
    } on FirebaseException catch (e) {
        print(e.message);
      
    }catch (e){
       
       print(e.toString());
    }
    

  }
}
