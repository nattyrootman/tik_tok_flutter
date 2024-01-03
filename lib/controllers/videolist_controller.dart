
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hop_tock/constants/firebase_instance.dart';
import 'package:hop_tock/models/user_model.dart';
import 'package:hop_tock/models/video_model.dart';

class VideoListController extends  GetxController{

 static VideoListController  instance= Get.find();
final Rx<List<VideoModel>>videoList=Rx<List<VideoModel>>([]);

//RxList<VideoModel>videolModle=RxList<VideoModel>([]);
//https://www.youtube.com/watch?v=SzhIY5qooCA&list=PLxefhmF0pcPl3jqJ6ShVsStVxtWQWS1pW&index=13



     List<VideoModel>myList=[];



  List<VideoModel> get getList => videoList.value;
      
      String myVideodId ="";

          @override
  void onInit() {
    super.onInit();

      
      videoList.bindStream(getAllVideos());


  }



  
  
  

  Stream<List<VideoModel>> getAllVideos(){

   return fireStore.collection("videos").snapshots()
    .map((event) => event.docs.map((e) =>VideoModel.fromMap(e) ).toList());


   }

      LikingVideo(String id)async{
          
          try {
            
          
      

      var uid=authController.user.uid;
       String uid1= firebaseAuth.currentUser!.uid;

      DocumentSnapshot  userDoc=await fireStore.collection("videos").doc(id).get();

          var likesDoc=(userDoc.data()! as  dynamic)['likes'];
           
            
            print(uid);
         if((userDoc.data()! as dynamic)['likes'].contains(uid)){
            
                await fireStore.collection("videos").doc(id).update({'likes':FieldValue.arrayRemove([uid]),})
                .whenComplete(() => print("its updated")).onError((error, stackTrace) => print(error));
                  
         }else{
                    
             await fireStore.collection("videos").doc(id).update({'likes':FieldValue.arrayUnion([uid])});

           print("nothin is added");
         }
          }
         on FirebaseException catch (e) {

         Get.snackbar("title:", e.message!);
         print(e.message);

           
      
    
         } catch (e) {
            

            print("error:${e.toString()}");
          }

        
    
}

}