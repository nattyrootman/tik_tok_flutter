

// ignore_for_file: unused_local_variable
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hop_tock/main_screeen/home_page.dart';
import 'package:hop_tock/models/user_model.dart';
import 'package:hop_tock/models/video_model.dart';
import 'package:get/get.dart';
import 'package:video_compress_plus/video_compress_plus.dart';
// ignore: depend_on_referenced_packages
//import 'package:video_compress/video_compress.dart';


import '../constants/firebase_instance.dart';

class UploadVideoController extends GetxController{

  compressVideo(String path)async{

    final compress= await VideoCompress.compressVideo(path,

       quality: VideoQuality.MediumQuality

    );


       return compress!.file;
   }


 
 Future<String> UploadVideoStorage( String Id,Uint8List? videoPath)async{



     
     Reference refStorage= storage.ref().child("videos").child(Id);
       
      final meta=SettableMetadata(contentType: "video/mp4");
      final taskUplaod=    refStorage.putData(videoPath!,meta);
      taskUplaod.whenComplete(() => print("video is   upload"));

        
        TaskSnapshot taskSnapshot=  await taskUplaod;
      
      String videoUrl=await taskSnapshot.ref.getDownloadURL();


     return videoUrl;


     

  }

   _getThumbNail(String videoPath)async{

    final Thumbnail=await  VideoCompress.getFileThumbnail(videoPath);

    return Thumbnail;
   }

 Future <String>ThumbnailImageStorage(String id,File? videoPath)async{

  final refStorage=storage.ref().child("thumnails").child(id);

  final task=refStorage.putFile(videoPath!);
  String thumnailUrl=await task.snapshot.ref.getDownloadURL();

  return thumnailUrl;


 }



   fireStoreDoc(String songName,String caption,Uint8List ?videoPath)async{

    try {

      String uid= firebaseAuth.currentUser!.uid;
      var  userDoc=await fireStore.collection("users").doc(uid).get();

     final allVideoDoc=await fireStore.collection("videos").get();

     final len=allVideoDoc.docs.length;



    String videoId=DateTime.now().millisecondsSinceEpoch.toString();
    String videourl =await UploadVideoStorage(videoId, videoPath!);

   // String thumbnail= await ThumbnailImageStorage("${len}", videoPath);   
    print(" url:$videourl");
     
     print(userDoc);



   var name= userDoc.data()!["userName"];
    var  photoProfile=userDoc.data()!["userPhoto"];
       
         
     var videoModel=VideoModel(userName:(userDoc.data()! as Map<String, dynamic>)['userName'],
             uid: uid,
             id:videoId,
             likes: [0],
             commentsCount: 0, 
             shareCount: 0, 
             songName: songName,
             caption: caption,
             userPhoto:(userDoc.data()! as Map<String, dynamic>)['userPhoto'],
             videourl: videourl,
            
             );


                 print("name");
            
            await fireStore.collection("videos").doc("$len").set(videoModel.toMap())
             .whenComplete(() => print("video and urls are uploaded"));

           Get.snackbar("brav", "video is uploaded");
           Get.to(MyHomePage());
      
        
    } on FirebaseException catch (e) {

      Get.snackbar("title:", e.message!);

      print(e.message!);
      
    }catch(e){
           
           Get.snackbar("title =",e.toString());
           print(e.toString());
      
    }


   }

  
}