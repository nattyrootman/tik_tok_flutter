


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hop_tock/controllers/videolist_controller.dart';
import 'package:hop_tock/video/video_controler.dart';

import '../signs_screens/auth_controllers/auth_controller.dart';



var firebaseAuth=FirebaseAuth.instance;

var fireStore=FirebaseFirestore.instance;
final authController=AuthController.instance;

 final storage=FirebaseStorage.instanceFor(bucket:"gs://hoptok-addff.appspot.com" );
final myStorage=FirebaseStorage.instance;

final videolist_controller=VideoListController.instance;