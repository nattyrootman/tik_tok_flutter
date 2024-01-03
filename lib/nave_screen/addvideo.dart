

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hop_tock/video/confirm_video.dart';
import 'package:image_picker/image_picker.dart';

import '../video/video_controler.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {


     _simpleDiadlog(){

      return showDialog(context: context, builder:(context){

        final  _videoController=Get.put(MyVideoController());
        return SimpleDialog(
          children: [
           
           SimpleDialogOption(onPressed: (){

           
           _videoController.pickVideo(ImageSource.gallery);

           },
           child: Row(children: [

             Icon(Icons.photo_album),
             Padding(padding: EdgeInsets.all(8),
             child: Text("Gallerie"),
             )
           ],),
           
           ),

           SimpleDialogOption(onPressed: (){

            
             _videoController.pickVideo(ImageSource.gallery);
           },
           child: Row(children: [

             Icon(Icons.photo_camera),
             Padding(padding: EdgeInsets.all(8),
             child: Text("Camera"),
             )
           ],),
           
           ),


           SimpleDialogOption(onPressed: (){

                    Navigator.pop(context);

           },
           child: Row(children: [

             Icon(Icons.cancel),
             Padding(padding: EdgeInsets.all(8),
             child: Text("Annuler"),
             )
           ],),
           
           )
           
          ],


        );

      });
     }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Center(
        child: InkWell(
          onTap: (){
             
             _simpleDiadlog();
          },
      
          
            child: Container(
              width:170,
              height:50,
             margin: EdgeInsets.symmetric(horizontal: 10),
                 padding: EdgeInsets.all(10),
            
              child: Text(
                   textAlign:TextAlign.center, 
                "Add Video",style: TextStyle(fontSize: 20),),
               
               decoration: BoxDecoration(
                color: Colors.redAccent
               ),
          
            
            ),
          )
          
        
      )

     
    );
  }
}