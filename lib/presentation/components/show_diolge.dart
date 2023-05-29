import 'package:flutter/material.dart';

Future ShowDiolge({
  context ,
  Widget? title,
  Widget? content,
  double? height,
  double? width,
  List<Widget>? action,
}){
  return showDialog(

      context: context,
      builder: (contex){
        return Container(
          width:width ,
          height: height,
          child: AlertDialog(
          title: title,
            actions: action,
            content: content,

          ),
        );
      }
  );
}