import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/presentation/components/show_diolge.dart';
import 'package:firebase_app/presentation/components/task_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/constance.dart';
import '../components/drawer_widget.dart';
import 'details_task_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String? TaskCategory;
  @override
  Widget build(BuildContext context) {
   Size size= MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Tasks', style: TextStyle(
          color: Colors.black
        ),),
        actions: [
          IconButton(
              onPressed: (){
                ShowDiolge(
                  width: size.width*0.9,
                  height: 100,
                  context: context,
                  title: Row(
                    children: const [
                      Icon(Icons.category,color: Colors.pink,),
                      Text('Task Category', style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),),

                    ],
                  ),
                  content: ListView.builder(
                    shrinkWrap: true,
                    itemCount:Constances. Category.length,
                      itemBuilder: (context , index){
                        return Row(
                          children: [
                            Icon(Icons.cloud_done, color: Colors.pink,),
                            TextButton(
                                onPressed: (){
                                  setState(() {
                                    TaskCategory = Constances.Category[index];
                                  });
                                },
                                child: Text(Constances.Category[index],

                                  style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,

                                ),)
                            ),
                          ],
                        );
                      }
                  ),
                  action: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Close',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,

                          ),
                        ),
                    ),
                    TextButton(
                      onPressed: (){
                        setState(() {
                          TaskCategory= null;
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Cancel Filter'
                        ,
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,

                        ),
                      ),
                    ),
                  ]
                );
              },
              icon: Icon(Icons.filter_list,color: Colors.black),
          ),
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
             // height:5000,
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection('Tasks').
                where('taskCategory' , isEqualTo: TaskCategory)
                    .snapshots() ,
                builder: (context, userSnaoshot){
                  if(userSnaoshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.amber,),);
                  }else if(userSnaoshot.connectionState ==ConnectionState.active){
                    if(userSnaoshot.data!.docs.isNotEmpty){
                      return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        //reverse: true,
                        itemCount: userSnaoshot.data!.docs.length,
                        itemBuilder: (context , index){
                        //  final isDone =userSnaoshot.data!.docs[index]['isDone'];
                          return CardTaskScreen(
                            onTap: (){},
                            onLongTap: (){

                              ShowDiolge(
                                context: context,
                                title: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: (){
                                        final User? user = auth.currentUser;
                                        final _uid= user!.uid;
                                        if(userSnaoshot.data?.docs[index]['upLoaded']==_uid){
                                          FirebaseFirestore.instance.
                                          collection('Tasks').doc(userSnaoshot.data?.docs[index]['taskID']).delete();
                                        }else{
                                          Fluttertoast.showToast(
                                              msg: "Sorry Don\'t have Right",
                                              toastLength: Toast.LENGTH_LONG,
                                              // gravity: ToastGravity.CENTER,
                                              backgroundColor: Colors.amber,
                                              textColor: Colors.pink,
                                              fontSize: 14.0
                                          );
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Delet', style: TextStyle(
                                            color: Colors.red,
                                          ),),
                                          Icon(Icons.delete_rounded,color: Colors.red,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            trailing: IconButton(
                              onPressed: (){},
                              icon: IconButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      DetailsTaskView(
                                        taskid:'${userSnaoshot.data!.docs[index]['taskID']}',
                                        Userid:'${userSnaoshot.data!.docs[index]['upLoaded']}' ,
                                      )));
                                },
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ),
                            title: '${userSnaoshot.data!.docs[index]['taskTitle']}',
                            subtitle: '${userSnaoshot.data!.docs[index]['taskDescription']}',
                            leading:userSnaoshot.data!.docs[index]['isDone']==false ?
                            Icon(Icons.access_alarm ,size: 50,color: Colors.pink,)
                                 //   :Icon(Icons.done_outline_sharp)
                           :Icon(Icons.done_outline_sharp, size: 50,color: Colors.amber,),
                          );
                        },
                        separatorBuilder: (context , index){
                          return SizedBox(
                            height: 7.0,
                          );
                        },

                      );
                    }else{
                      return Center(child: Text('No User Has Been Uploaded0'));
                    }
                  }
                  return Center(child:  Text('No User Has Been Uploaded'),);

                },
              )
            )
          ],
        ),
      ),
    );
  }
}
