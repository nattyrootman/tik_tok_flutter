

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/controllers/comment_controller.dart';

class CommentScreen extends  StatelessWidget {

 final String id;
  const CommentScreen({super.key,required  this.id});

    

  @override
  Widget build(BuildContext context) {

     TextEditingController  editingController=TextEditingController();

     var comment_controller=Get.put(CommentsController());

       comment_controller.updateComment(id);


   return Scaffold(
    backgroundColor: Colors.grey,

      appBar: AppBar(
        title: Text("123 Comments",style:TextStyle(fontWeight: FontWeight.w900,fontSize: 20)),
        actions: [],),

    body:Obx ((){return SingleChildScrollView(
         
        child:SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: Column(children:[

           Expanded(
             child: ListView.builder(
              itemCount: comment_controller.getCommentList.length,
              itemBuilder: (context,int index){

               var date=DateTime.now();
               var data=  comment_controller.getCommentList;
                return ListTile(

                  leading: CircleAvatar(
                    radius: 50,
                    child: Image.network(data[index].userPhoto,fit: BoxFit.cover,width: 50,height: 50)),
                  //Icon(Icons.person),
                    title: Text(data[index].userName),
                    subtitle: Text(data[index].comment),
                  );
                       
                
              }),
           ),
            
            Row(
             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                   
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: editingController,
                       
                      decoration: InputDecoration(
                          hintText: "Comment",
                         hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black),
                              
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.blue)
                              
                          ),
                    
                      ),
                    ),
                  ),
                ),
                InkWell(
                  
                  onTap:()async{
                    var d=authController.user.uid;
                    DocumentSnapshot userDoc=await fireStore.collection("videos").doc(d).get();
                   comment_controller.PostComment(editingController.text);
                   
                       editingController.text="";
      

                  },
                  child: Icon(Icons.send,color:Colors.blue))
              ],
            )
          
          ]),
        )

      
    );
     })
   );
  }
}


