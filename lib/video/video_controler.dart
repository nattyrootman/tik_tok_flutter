
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:hop_tock/video/confirm_video.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
class MyVideoController extends GetxController{

        
        static MyVideoController instance =Get.find();

              
         File? file; 

         Uint8List? uint8list;

         void pickVideo(ImageSource source) async {
           
           try{

           // FilePickerResult? result= await FilePicker.platform.pickFiles(type: FileType.video);


           //Uint8List? web=await ImagePickerWeb.getVideoAsBytes();
          final pickerVideo=await ImagePicker().pickVideo(source: source);
              if(pickerVideo!=null){

               Uint8List?  uint8list= await pickerVideo.readAsBytes();

               // final path=result.files.single.path!;
             // file=File(pickerVideo.path);
             

                    Get.to(ConfirmVideo(uint8list:uint8list ,videoPath:pickerVideo.path ,));
                  
                
              }else{

                   Get.snackbar("error:", "Smothing went wrong");
        
                } 
              }catch(e){

              print(e.toString());
              Get.snackbar("error:", e.toString());
           }

        }
      }