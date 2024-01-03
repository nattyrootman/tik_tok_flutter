




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hop_tock/controllers/comment_controller.dart';

modal (BuildContext context,String id,TextEditingController editingController){

   var comment_controller=Get.put(CommentsController());
      comment_controller.disposeId(id);
   
    return showModalBottomSheet(
      backgroundColor: Colors.grey,
       elevation:12 ,
       useSafeArea: true,
       constraints: BoxConstraints.expand(),
      context: context,builder: (context){

      return SingleChildScrollView(
         
        child:SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: Column(children:[

          
           Row(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            children: [Text("1233 Comments",style: TextStyle(color: Colors.black,fontSize: 20),),
              Icon(Icons.close,color:Colors.black)
    
           ],
           
           ),

           Expanded(
             child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context,int dex){

                var commentItem=comment_controller.getCommentList[dex];
                return ListTile(
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
                  
                  onTap:(){
                    
                   
                    editingController.text="";

                

                  },
                  child: Icon(Icons.send,color:Colors.blue))
              ],
            )
          
          ]),
        )

      );
        
      });
     }


