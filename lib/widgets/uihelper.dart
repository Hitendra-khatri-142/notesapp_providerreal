import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class uiHelper{

  static CustomTextField(TextEditingController controller,String text,IconData iconData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
      child: TextField(

        controller: controller,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon:Icon(iconData),
          hintText: text
        ),
      ),
    );

  }
}