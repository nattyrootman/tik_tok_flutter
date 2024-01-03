import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ButtonWidget   extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Container(
          
          width: 160,
          height: 50,
           decoration: BoxDecoration(
            color:Colors.red,
            borderRadius: BorderRadius.circular(5)
           ),
          
          
         child: Center(child: Text("Suivre",style: TextStyle(fontSize:20)))
         ),
           
           SizedBox(width:5),
         Container(
           width: 45,
           height: 50,
          decoration: BoxDecoration(
            color:Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5)
           ),
          
          child: Icon(Icons.arrow_drop_down,size: 40,color:Colors.black))

      ],)


    );
  }
}