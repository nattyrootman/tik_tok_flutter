



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hop_tock/controllers/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {

TextEditingController controller= TextEditingController();
    var search_controller=Get.put(SearchingController());

     
    return Obx(() { return Scaffold(


      backgroundColor:Colors.grey,
       
       appBar: AppBar(
    
        elevation: 40,
         title:
          Container(
            height: 45,
            
              
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 2),
            child: TextFormField(
              //controller: controller,
               decoration: InputDecoration(
               
                 prefix: Icon(Icons.search),
                 hintText: "Rechercher",
                  filled: false,
                   
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black))
            

            
               ),
            
               onFieldSubmitted: (value){
               
                search_controller.getUser(value);
               
               },
            
            ),
          ),
          

       ),
      body:search_controller.FindingUser.isEmpty?Center(child:Text("Find User"),)
      :ListView.builder(
        itemCount: search_controller.FindingUser.length,
        itemBuilder: (context,int index){
          var data=search_controller.FindingUser[index];
        return ListTile(

          leading: CircleAvatar(
            radius: 50.0,
            child: Image.network(data.userPhoto,fit: BoxFit.cover,)),
        );
      })
    );
  });
  }
}