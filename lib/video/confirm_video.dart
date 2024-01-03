
 import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/video/upload_controller.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../widgets/textfield.dart';



class ConfirmVideo extends  StatefulWidget {
 
  final Uint8List ?uint8list;
 final String ? videoPath;
  
   const ConfirmVideo({super.key,this.uint8list,this.videoPath});
 
   @override
   State<ConfirmVideo> createState() => _ConfirmVideoState();
 }
 
 class _ConfirmVideoState extends State<ConfirmVideo> {
      
     late final Player _player=Player();
     late final   _playerController= VideoController(_player);
     

     TextEditingController songController=TextEditingController();
     TextEditingController captionController=TextEditingController();

     @override
     void initState() {
       super.initState();
       playerVideo();


       
     }
      

      void playerVideo()async{
          
            try {

              if(widget.uint8list!=null ||widget.videoPath!.isNotEmpty){

                _player.open(Media(widget.videoPath!));
                 await  _player.play();
              }else{

                 Get.snackbar("error", "quelque chose ne marche pas");
              }
              
            } catch (e) {

              Get.snackbar("error", e.toString());
              
            }
      }

   @override
   Widget build(BuildContext context) {

    final uploadVideoController=Get.put(UploadVideoController());
     return Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [

          SizedBox(height: 20,),
          
         SizedBox(
                  width: MediaQuery.of(context).size.width/1.2,
                 height: MediaQuery.of(context).size.height/1.2,
                  
                 child:
                 InkWell(
                  onTap: (){},
                  child: Video(controller:_playerController))
               ),
               SizedBox(height: 20,),

               SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Textfields(controller:songController,labelText: "Song Name", icon: Icons.music_note)

                      ),
                        SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Textfields(controller:captionController,labelText: "Caption", icon: Icons.closed_caption)

                      ),
                      SizedBox(height: 10),

                      ElevatedButton(onPressed: (){
                     



                        //UploadVideoStorage(firebaseAuth.currentUser!.uid,widget.uint8list!);
                        uploadVideoController..fireStoreDoc(songController.text,captionController.text,
                        widget.uint8list!);
                          
                          
                      }, child: Text("Share",style: TextStyle(fontSize: 20),)),
                      SizedBox(height:35)
                      
                  ],),
                )

        ]),


      ),
           


     );
   }
 }
