

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/controllers/profile_controller.dart';
import 'package:hop_tock/widgets/button.dart';


class ProfileScreen extends StatefulWidget {

  final String? uid;
  const ProfileScreen({super.key,this.uid});

  @override
  State<ProfileScreen> createState() => _nameState();
}

class _nameState extends State<ProfileScreen> {

   final profileController=Get.put( ControllerProfile());


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.UpDateProfile(widget.uid!);
  }
  @override
  Widget build(BuildContext context) {

  return GetBuilder< ControllerProfile>(
    init:  ControllerProfile(),
    builder: (controller){

      //if(profileController.userFollowers.userName.isEmpty){
        
       // return Center(child: CircularProgressIndicator());
      //}

    return Scaffold(



      appBar:AppBar(title:ElevatedButton(onPressed:()=>
      firebaseAuth.signOut(),
     

        child:Text("Log out"))),
         
      body:SingleChildScrollView(
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
         
          children: [
                Container(
                 // margin: EdgeInsets.symmetric(vertical: 10),
                 padding: EdgeInsets.all(10),
                 width: double.infinity,
                 decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border(bottom: BorderSide(color: Colors.black))
                 ),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Icon(Icons.arrow_back_ios,color: Colors.black),
                     Text("love",style: TextStyle(fontSize: 20,color:Colors.black),),
                     Icon(Icons.share,color:Colors.black),

                   ],
                 ),
               ),
            SizedBox(height: 20),
            Container(
               margin: EdgeInsets.symmetric(vertical: 20),
              child:  Column(
                children: [

                  Center(child: Image.asset("assets/avatar.png")),
                    SizedBox(height: 10),
                  Text(profileController.userFollowers.userName),
                ],
              )),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                      Column(children: [
                         Text('${profileController.userFollowers.following}',style: TextStyle(color: Colors.white)),
                          Text("Abonnements",style: TextStyle(color: Colors.grey.shade300)),
                      ],),

                      Column(children: [
                         Text(profileController.userFollowers.toString()),
                          Text("Abonnés",style: TextStyle(color: Colors.grey.shade300)),
                      ],),

                      Column(children: [
                         Text("1.M",style: TextStyle(color: Colors.white)),
                          Text("J'aime",style: TextStyle(color: Colors.grey.shade300)),
                      ],)

                ],),
                 SizedBox(height: 15),

                ButtonWidget(uid:widget.uid)
                

          ],
        ),
      )
   
    );
    
  
     });
     
  }
}