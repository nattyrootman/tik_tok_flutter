import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hop_tock/controllers/videolist_controller.dart';
import 'package:hop_tock/main_screeen/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hop_tock/signs_screens/login.dart';
import 'package:hop_tock/signs_screens/sign_up.dart';

//import 'firebase_options.dart';

import 'package:flutter/foundation.dart';

import 'signs_screens/auth_controllers/auth_controller.dart';



  //25:31:3E:A2:52:ED:38:05:D9:31:BA:7C:72:3C:37:74:72:C7:97:8D

  
 







 String apiKey="AIzaSyDhXXUQf5Xsk6Fg2XtEsVU3reH7_akAwes";
 String authDomain="hoptok-addff.firebaseapp.com";
 String projectId= "hoptok-addff";
String  storageBucket="hoptok-addff.appspot.com";
 String messagingSenderId= "629245277294";
 String appId= "1:629245277294:web:4db1a31182f1d97588e27f";


 
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  

    if(kIsWeb){


    await Firebase.initializeApp(options:
     FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId))
     .then((value) { Get.put(AuthController());
  
        }
     );
   
    }else{ 
      await Firebase.initializeApp();
    }


  runApp(

        //const   MyApp(),
      DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools
        
      ],
      builder: (context) => const   MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
       theme: ThemeData.dark().copyWith(
       
       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      
        scaffoldBackgroundColor: Colors.black), 


        home:SignUpScreen()
  
         /* getPages:[GetPage( name: '/', page: ()=>MyHomePage()),
                  GetPage( name: '/signUp_screen', page: ()=>SignUpScreen()),
                  GetPage( name: '/login_screen', page: ()=>LoginScreen()

                  
       
       ],*/
    );
  }
}

