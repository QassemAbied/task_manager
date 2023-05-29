import 'package:flutter/material.dart';

Widget defaultTextFromField({
  required TextInputType type,
  required Function Fxt  ,
  FocusNode? focusNode,
  // Function onFieldSubmitted,
   TextInputAction? textInputAction,
  Function? onEditingComplete,
  required String hintText,
   IconData? prefix,
  Widget? suffix,
  required bool obscure,
  required TextEditingController controller,
  Widget? changeIcon,
  bool? enabled,


})=>  TextFormField(
  controller:controller ,
  focusNode: focusNode,
  keyboardType: type,
  cursorColor: Colors.white,
  obscureText: obscure,
  textInputAction: textInputAction,
  enabled: enabled,

  validator:(value){ Fxt();} ,
  //onFieldSubmitted: (value){onFieldSubmitted!();},
  onEditingComplete: (){onEditingComplete!();},
  decoration: InputDecoration(
hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white,
    ),

    prefixIcon: Icon(prefix, color: Colors.white,),
    suffixIcon: suffix,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    disabledBorder:OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    )  ,
    focusedBorder:OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ) ,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
  ),

);