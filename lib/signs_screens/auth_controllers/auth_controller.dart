

//import 'dart:html';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:hop_tock/main_screeen/home_page.dart';
import 'package:hop_tock/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/firebase_instance.dart';

import '../sign_up.dart';

class AuthController extends GetxController{

   static AuthController instance=Get.find();
  late Rx<File?>file;
    
   late Rx<User?>_user;
 // Uint8List? uint8list;

     bool load=false;
     String filename='';
     String downloadURL='';
        
        User get user=>_user.value!;

      @override
      void onReady() {
        super.onReady();
         
         _user=Rx<User?>(firebaseAuth.currentUser);
         _user.bindStream(firebaseAuth.authStateChanges());
          ever(_user,  initialser);
        
      }


       initialser(User?user){
        if(user==null){
           
           Get.offAll(()=>SignUpScreen());

        }else{
         Get.offAll(()=>MyHomePage());

        }

        
       }
      Future<String> putData(Uint8List?uint8list)async{
      

       try {

        if(uint8list!=null){
             
             final meta=SettableMetadata(contentType: "image/jpeg");
           final uplo  =  await storage.ref().child("PhotoUser/$filename")
              .putData(uint8list,meta);
              
              downloadURL=await uplo.ref.getDownloadURL();
         
              print("sucess :  $downloadURL");      
          
          }else{

            Get.snackbar("error" ,"something wrong happens");
            print("rien ne va "); 
            
          }
        
       
         
       } on FirebaseException catch (e) {
         Get.snackbar("error", e.message!);
           print("${e.message!}" );

         
       }catch(r){
         Get.snackbar("error:file", r.toString());
          
          print( r.toString());

       }
        
      
     return downloadURL;

    } 
  
  void SignUp(String name,String email ,String password,Uint8List ?uint8list)async{
      
         
       try {
            
        if(name.isNotEmpty&& email.isNotEmpty&& password.isNotEmpty&&uint8list!=null){


        String userPhoto=await putData(uint8list);
         load=true;
       UserCredential userCred= await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
         
          Get.snackbar("Brabo !", "you have succefully created your account");
              
        UserModel userModel=UserModel(userName: name, userEamail: email, userPhoto: userPhoto, uid: userCred.user!.uid);
             
             await fireStore.collection("users").doc(userCred.user!.uid).set(userModel.toJson())
             .whenComplete((){
              print("data uploade in collection");
               
                
            }) ;
             

        }else{

          Get.snackbar("S'il vous plait !", "Les Champs doivent etre remplis");

        }

       } on FirebaseException catch(e){

         Get.snackbar("error", e.message!);

         
       }catch(e){
          
          Get.snackbar("error", e.toString());

       }

  }

    void Sign_In(String email,String password)async{

    try {
       if(email.trim().isNotEmpty && password.trim().isNotEmpty){

        
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
        .whenComplete((){
           load=false;
           Get.snackbar("connected", " tu es mainteant connecté");
        });


       }else{

         Get.snackbar("error", " quelque chose ne va pas  Ressayer");
       }
      
      
    } on FirebaseException catch (e) {
        Get.snackbar("error", e.message!);

      
    }catch(e){
          
          Get.snackbar("error", e.toString());

       }


}

     

}