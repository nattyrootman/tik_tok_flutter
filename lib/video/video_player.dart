

import 'package:flutter/material.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/video/video_controler.dart';
import 'package:video_player/video_player.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:get/get.dart';




class VideoPlayerScreen extends StatefulWidget {

  final String ?videoUrl;
  const VideoPlayerScreen({super.key,this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _nameState();
}

class _nameState extends State<VideoPlayerScreen> {


    late VideoPlayerController _playerController;

      Player player=    Player();
 late  final   controller= VideoController(player);

 bool isplaying=false;
 
      
       void  Players()async{
    
      
        
        _playerController=VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
         _playerController.initialize();
         
          _playerController.play();
         _playerController.setVolume(2);
         _playerController.setLooping(true);
         

      }

    /*  another player video library 
     PlayVideo()async{
           if(widget.videoUrl!.isNotEmpty){

        player.open(Media('${widget.videoUrl}'));
         await  player.play();

      }else{
         print("video can not play");
      }
       }*/


   @override
   void initState() {
     super.initState();
     
          

         //  PlayVideo();
         Players();

          /*_playerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!))
      ..initialize().then((value) {
        _playerController.play();
        _playerController.setVolume(1);
      });*/

   }
     
    

      @override
      void dispose() {
        
        super.dispose();
         _playerController.dispose();
      }


  @override
  Widget build(BuildContext context) {
    
    
        return 
        Container(
                  width:MediaQuery.of(context).size.width,
              
                 height:MediaQuery.of(context).size.height,
                 decoration: BoxDecoration(
              
                  color: Colors.black,
                 
                 ),
                 child://Video(controller:controller),
                
                     VideoPlayer(_playerController)
                  
                
              
        );
        
      
  }
}