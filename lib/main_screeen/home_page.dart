
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/models/user_model.dart';
import 'package:hop_tock/nave_screen/addvideo.dart';
import 'package:hop_tock/nave_screen/home_srceen.dart';
import 'package:hop_tock/nave_screen/message.dart';
import 'package:hop_tock/nave_screen/profile.dart';
import 'package:hop_tock/nave_screen/search.dart';

import 'package:hop_tock/constants/firebase_instance.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentIndex=0;

  List<Widget>pages=[
    const HomeScreen(),
    const SearchScreen(),
    const AddVideoScreen(),
    const MessageScreen(),
     ProfileScreen(uid: authController.user.uid,)

  ];





  @override
  Widget build(BuildContext context) {

   
   

    
    return Scaffold(

     
        
        
      bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
  
        currentIndex: currentIndex,

        onTap: (int dex){

          setState(() {
            currentIndex=dex;
          });
        },
        
        items: [
       
        BottomNavigationBarItem(
        label: "Home",
          icon:Icon(Icons.home)),

          
        BottomNavigationBarItem(
        label: "Explore",
          icon:Icon(Icons.explore)),
          
        BottomNavigationBarItem(
        label: "Add Video",
          icon:Icon(Icons.add)),

          
        BottomNavigationBarItem(
        label: "Message",
          icon:Icon(Icons.message)),
          
        BottomNavigationBarItem(
        label: "Profile",
          icon:Icon(Icons.person))

      ]),

      

    body: pages[currentIndex]

    );


  }
}