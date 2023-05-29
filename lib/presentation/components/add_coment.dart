import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AddComment extends StatelessWidget {
   AddComment({Key? key , required this.taskid}) : super(key: key);
   final String taskid;
 List<Color> _colors=[
   Colors.black,
   Colors.pink,
   Colors.deepOrangeAccent,
   Colors.deepPurple,
   Colors.amber,
   Colors.blue,
   //Colors.blue,
 ];
  @override
  Widget build(BuildContext context) {
   _colors.shuffle();
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Tasks').doc(taskid).get(),
        builder: (context , taskSnapshot){
        if(taskSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: Colors.amber,),);
        }else{
          if(taskSnapshot == null){
            return Center(child: Text('Not Found Data'),);
          }
          return  ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: taskSnapshot.data!['Comment'].length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
             reverse: true,
            itemBuilder: (context , index){
              return   Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: _colors[4],
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            taskSnapshot.data!['Comment'][index]['imageusercomment'],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    //flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            taskSnapshot.data!['Comment'][index]['name'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            taskSnapshot.data!['Comment'][index]['commentbody'],
                            //maxLines: 3,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context , index){
              return SizedBox(
                  height: 5,
                  child: Divider(thickness: 0.3,)
              );
            },
          );

        }

        }
    );
  }
}
