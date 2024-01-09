


// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/controllers/videolist_controller.dart';
import 'package:hop_tock/models/user_model.dart';
import 'package:hop_tock/models/video_model.dart';
import 'package:hop_tock/video/video_player.dart';
import 'package:hop_tock/views/comments_screen.dart';
import 'package:hop_tock/widgets/comments_widget.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:video_player/video_player.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


  
class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin  {

   //  Player player=    Player();
    //  late  final   controller= VideoController(player);
    TextEditingController  editingController=TextEditingController();

       final videolist=Get.put(VideoListController());

  late AnimationController controller;

 String name="bob";
       @override
       void initState() {
         super.initState();

         
               controller =AnimationController(vsync: this,duration: Duration(milliseconds: 5000));

               controller.forward();
               controller.repeat();
        
         
       }



       

   
         

     UsersAlbum(String profilePhoto){

      return SizedBox(height: 60,width: 60 ,
      child: Column(
        children: [
          Container(

              padding: EdgeInsets.all(8.0),
             width: 50,
                height: 50,
                decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(25),

              gradient: LinearGradient(colors: [Colors.grey,Colors.white]), 
              
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(25),

              child: Image.network(profilePhoto),
              ),


          ),
        ],
      ),
      
      );
       


     }
        


     CurrentUserProfilePhoto(String profilePhoto){
        
      return SizedBox(height: 60,width: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(25),

          color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image(image: NetworkImage(profilePhoto),fit: BoxFit.cover,)),)
          
          ),

            Positioned(
                   top: 40,
                   left:15,
                   right:15,

             child: Container( 
              width: 15,
              height: 25,
              decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.red),
            child: Icon(Icons.add,color:Colors.white,size:10))
            )

      ],)
      


      
      );
     }

  @override
  Widget build(BuildContext context) {
    var con=Get.put(VideoListController());
    
    
    return Scaffold(

        
      body:Obx((){ return PageView.builder(
                 itemCount: videolist.getList.length,
                  controller: PageController(initialPage: 0,viewportFraction: 1),
                 scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext conetx ,int index){
                  
                    var data=videolist.getList[index]; 
                      
                    
                  return Stack(children: [
                      
                     VideoPlayerScreen(videoUrl: data.videourl),


                    
                       SizedBox(height:100),
                     Column(
                    
                       children: [
                         Expanded(
                           child: Row(
                            
                             mainAxisSize: MainAxisSize.max,
                             crossAxisAlignment: CrossAxisAlignment.end,
                            children:[
                         
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                   mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children:[
                                                       
                                  Text(videolist.getList[index].userName),
                                  Text(videolist.getList[index].caption),
                                                       
                                  Row(children:[
                                    Icon(Icons.music_note),
                                    Text(videolist.getList[index].songName)
                                  ])
                                ]),
                              ),
                            ),
                         
                            Container(
                              width:100,
                              margin:EdgeInsets.only(top:MediaQuery.of(context).size.height/5),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                
                                children: [  
                                
                                CurrentUserProfilePhoto(data.userPhoto),
                               Column(children:[
                                InkWell(
                                  onTap:()async{

                                       var uid=authController.user.uid;
                                         


                                            videolist.LikingVideo(data.id);
                                               
                                        
                                  },
                                  
                                  child: Icon(Icons.favorite,size:40,
                    
                                  color:data.likes.contains(data.uid)?Colors.red:Colors.white)),
                                  const SizedBox(height: 5),
                                 Text(data.likes.length.toString())
                               ]), 
                               //const SizedBox(height: 5),
                         
                                  
                                Column(children:[
                                InkWell(
                                  onTap: (){
                                  // modal(context,videolist.getList[index].id,editingController);
                                     Get.to(CommentScreen(id:data.id));
                                  },
                                  child: Icon(Icons.comment,size:40,color:Colors.white)),
                                  const SizedBox(height: 5),
                                 Text("${data.commentsCount}")
                               ]),
                                
                                
                                Column(children:[
                                Icon(Icons.reply,size:15,color:Colors.white),
                                  const SizedBox(height: 5),
                                 Text("0")
                               ]),
                               
                                 RotationTransition(turns: Tween(begin: 0.0,end:1.0,).animate(controller),
                                 child:  UsersAlbum(videolist.getList[index].userPhoto),)
                                 
                                 
                               
                         
                            ],))
                         
                         
                           ]),
                         ),
                       ],
                     )
  
                  ]);

          });
      } )
     );

  }}
  
     