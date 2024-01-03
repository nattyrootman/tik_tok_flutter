import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hop_tock/constants/firebase_instance.dart';

class     ControllerProfile extends     GetxController{



  Rx<String>uid="".obs;


  updatePost(String id){
      uid.value=id;

  }



  getallUser ()async{

    var Videodoc=  await fireStore.collection("users").where("uid",isEqualTo: uid).get();
      
      List<String>listVideo=[];

      for(int i=0;i<Videodoc.docs.length;i++){

        listVideo.add((Videodoc.docs[i].data() as dynamic)["videourl"]);
      }


  


  }
}