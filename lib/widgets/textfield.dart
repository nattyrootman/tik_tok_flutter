
import 'package:flutter/material.dart';

class Textfields  extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final bool ?isObscur;
  final IconData icon;
  const Textfields({super.key,
  required this.controller,
  required this.labelText,
   this.isObscur,
  required this.icon});


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon:Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
          
      ),
    )
    );
  }
}