

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hop_tock/signs_screens/login.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/firebase_instance.dart';
import '../widgets/textfield.dart';
import 'auth_controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {

  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();



   Uint8List? uint8list;
    String filename="";
     var load=false;

  void PickFile()async{

    try {

      final   result= await FilePicker.platform.pickFiles(
        type: FileType.image);

  
     if(result!=null){
     
       final path= result.files.first.bytes;
       //final filename=result.files.first.name;

       setState(() {
          uint8list=path;
       authController.filename=result.files.first.name;
          
       });
     
        Get.snackbar("Bravo", "your photo is selected succefully ");

     }else{

      Get.snackbar("", "Smothing went wrong");
    }
   } on FileSystemException  catch (e) {

    Get.snackbar("error filepick:", e.toString());
    print(e.toString());
    
  }


}




    Widget getImage() {

    if(uint8list!=null){
     return CircleAvatar(
         radius: 64,
         backgroundImage:  MemoryImage(uint8list!));

        }else{

      return CircleAvatar(
           radius: 64,
           backgroundImage:  AssetImage("assets/avatar.png"));  
      
      }
    
}




  @override
  Widget build(BuildContext context) {
    
    
  final controller=Get.put(AuthController());


     

    return Scaffold(

      body:authController.load?Center(child: CircularProgressIndicator(),):Container(alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Text('TikTok',style: TextStyle(fontSize: 35,color: Colors.white),),

         Text('Register',style: TextStyle(fontSize: 25),),
         
         SizedBox(height: 25,),

          Stack(
            children: [
            
             getImage(),
            
            Positioned(
              left: 88,
              bottom: -10,
              child:IconButton(onPressed: (){
                 
                 PickFile();
             
              //authController.PickImage(ImageSource.gallery);
              },
             icon: const Icon(Icons.add_a_photo)) )
             
            ],

          ),

          SizedBox(height: 15),

          Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 25),
           child: Textfields(controller: name, 
           labelText: 'User Name', isObscur:false, icon:Icons.person),
         ),
          SizedBox(height: 20,),



         Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 25),
           child: Textfields(controller: email, 
           labelText: 'Email', isObscur:false, icon:Icons.email),
         ),
          SizedBox(height: 20,),


         Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 25),
           child: Textfields(controller: password, 
           labelText: 'Password', isObscur:false, icon:Icons.lock),
         ),
           SizedBox(height: 30,),

       Container(
          
          width: MediaQuery.of(context).size.width-40,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 25),
         

           decoration: BoxDecoration(
             color: Colors.red,
            borderRadius: BorderRadius.circular(5)
           ),
          child: InkWell(
            onTap: (){
               //authController.putData(uint8list) ;               
                authController.SignUp(name.text, email.text, password.text,uint8list);
                
               
                 setState(() {
                   authController.load=true;
                 });
                 


            },
            child: Center(child:
             Text('Create Account',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700))
            
             
             )
             ,
          ),
          

       ),

     SizedBox(height: 30,),
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(" you have already  account?",style: TextStyle(fontSize: 18)),

        InkWell(
          


        onTap: (){
           
           Get.to(LoginScreen());
        },
          child: Text("Login",style: TextStyle(fontSize: 20,color:Colors.red),))

          ],)
          
      ]),




      )
    );
  }
}








