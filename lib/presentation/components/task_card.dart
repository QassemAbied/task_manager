
import 'package:firebase_app/presentation/components/show_diolge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CardTaskScreen extends StatelessWidget {
   CardTaskScreen({Key? key ,this.onLongTap,
     this.onTap, required this.title,
     required this.subtitle, required this.trailing, required this.leading
   }) : super(key: key);
 Function? onLongTap;
 Function? onTap;
 final String title;
 final String subtitle;
 final IconButton trailing;
 final Widget leading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      child: Card(
        color: Colors.white54,
        child: ListTile(
          onTap: (){onTap!();},
          onLongPress: (){
           onLongTap!();
          },
          leading: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 0.4)),
              ),
              child:leading ),
          mouseCursor: MouseCursor.defer,
          title: Text(title, maxLines: 1,
            overflow: TextOverflow.ellipsis,),
          subtitle:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.linear_scale),
              Text(subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(

              ),),

            ],
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}

