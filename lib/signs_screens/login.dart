

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/firebase_instance.dart';
import '../widgets/textfield.dart';

class LoginScreen   extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
     final TextEditingController email=TextEditingController();

    final TextEditingController password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: authController.load?Center(child: CircularProgressIndicator(),):Container(alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Text('TikTok',style: TextStyle(fontSize: 35,color: Colors.white),),

         Text('Login',style: TextStyle(fontSize: 25),),
         
         SizedBox(height: 25,),

         Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 25),
           child: Textfields(controller: email, 
           labelText: 'Email', isObscur:false, icon:Icons.email),
         ),
          SizedBox(height: 25,),


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

                
               authController.Sign_In(email.text,password.text);
               

               
               setState(() {
                 authController.load=true;
               });
               
             // Get.to(SignUpScreen());
              // Get.toNamed("/log_up");
            },
            child: Center(child:
             Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)),
          ),

       ),

     SizedBox(height: 30,),
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text("Don't you have account?",style: TextStyle(fontSize: 18)),

        InkWell(
          onTap: (){

            print("Register");

            Get.toNamed("/signUp_screen");
          },
          child: Text("Register",style: TextStyle(fontSize: 20,color: Colors.red),))

     ],)
           



      ]),


      
      
      ),
    );
  }
}