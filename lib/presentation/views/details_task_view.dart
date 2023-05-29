
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../components/add_coment.dart';

class DetailsTaskView extends StatefulWidget {
  const DetailsTaskView({Key? key , required this.taskid , required this.Userid}) : super(key: key);
final String taskid;
  final String Userid;

  @override
  State<DetailsTaskView> createState() => _DetailsTaskViewState();
}

class _DetailsTaskViewState extends State<DetailsTaskView> {
  bool comment = true;
  final TextEditingController CommentController= TextEditingController();
 @override
  void dispose() {
    super.dispose();
    CommentController.dispose();
  }

   String authername='';
   String autherjob='';
   String authorimage='';
   String taskCategory ='';
   String taskTitle ='';
   String taskDescription='';
   String deadlineData ='';
   String taskID ='';
   String upLoaded ='';
   List Comment =[];
   bool isDone = true;
  String CreatedAt='';
  String deadlineDatatimeStamp='';
  bool isDeadlineAvailble=false;

  void getDetailsTasks()async{
    final DocumentSnapshot userDoc=await FirebaseFirestore.instance.collection('User').doc(widget.Userid).get();
    if(userDoc == null){
      return;
    }else{
      setState(() {
        authername= userDoc.get('name');
        autherjob= userDoc.get('positionCompany');
        authorimage= userDoc.get('userImageUrl');

      });
          }

    final DocumentSnapshot taskuserDoc=await FirebaseFirestore.instance.collection('Tasks').doc(widget.taskid).get();
    if(userDoc == null){
      return;
    }else{
      setState(() {
        taskDescription= taskuserDoc.get('taskDescription');
        taskID= taskuserDoc.get('taskID');
        upLoaded= taskuserDoc.get('upLoaded');

        isDone= taskuserDoc.get('isDone');
        taskTitle= taskuserDoc.get('taskTitle');
        final jioinTimestamp= taskuserDoc.get('CreatedAt');
        final jioinData= jioinTimestamp!.toDate();
        CreatedAt='${jioinData.year}-${jioinData.month}-${jioinData.day}' ;

        Timestamp jioinTimestamplast= taskuserDoc.get('deadlineDatatimeStamp');
        final jioinDatalast= jioinTimestamplast.toDate();
        deadlineDatatimeStamp='${jioinDatalast.year}-${jioinDatalast.month}-${jioinDatalast.day}' ;
        isDeadlineAvailble = jioinDatalast.isAfter(DateTime.now());



      });
    }
  }
  @override
  void initState() {
    super.initState();
    getDetailsTasks();
  }
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: authorimage.isNotEmpty,
        builder: (context){
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    taskTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white54,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'UploadedBy',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.pink,
                                child: CircleAvatar(
                                  radius: 30,
                                  child: CachedNetworkImage(
                                    imageUrl:authorimage==null?'': authorimage,
                                    imageBuilder: (context , ImageProvider){
                                      return CircleAvatar(
                                        radius: 30,
                                        backgroundImage: ImageProvider,
                                      );
                                    },
                                    placeholder: (context , child){
                                      return  CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage('assets/image/3.jpg'),
                                      );
                                      //return Image(image: AssetImage('assets/image/3.jpg'));
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      authername,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(color: Colors.pink , offset: Offset(1.5, 1.5)),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      autherjob,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(color: Colors.pink , offset: Offset(1.5, 1.5)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Uploaded On :',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'date : ${CreatedAt}',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Deadline Data :',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'date : ${deadlineDatatimeStamp}' ,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            isDeadlineAvailble? 'Still have enough time':' Now time left',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.pink,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Done State :',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: ()async{
                                        final FirebaseAuth auth = FirebaseAuth.instance;
                                        final User? user = auth.currentUser;
                                        final _uid= user!.uid;
                                        if(widget.Userid ==_uid){
                                       await   FirebaseFirestore.instance.collection('Tasks').doc(widget.taskid).update({
                                            'isDone': true,
                                          });
                                          getDetailsTasks();
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


                                      },
                                      child:Text('Done',
                                        style:TextStyle(
                                          color: Colors.amber,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ) ,
                                      ),

                                  ),
                                  Opacity(
                                      opacity: isDone==true? 1: 0,
                                      child: Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      )),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  TextButton(
                                    onPressed: ()async{
                                      final FirebaseAuth auth = FirebaseAuth.instance;
                                      final User? user = auth.currentUser;
                                      final _uid= user!.uid;
                                      if(widget.Userid ==_uid){
                                       await FirebaseFirestore.instance.collection('Tasks').doc(widget.taskid).update({
                                          'isDone': false,
                                        });
                                        getDetailsTasks();
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


                                    },
                                    child:Text('Not Done',
                                      style:TextStyle(
                                        color: Colors.pink,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ) ,
                                    ),

                                  ),
                                  Opacity(
                                      opacity: isDone==false?1 :0,
                                      child: Icon(
                                        Icons.check_box,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Task Description :',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                taskDescription,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child:comment? Center(
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    color: Colors.pink,
                                    onPressed: () {
                                      setState(() {
                                        comment =! comment;
                                      });
                                    },
                                    child: Text(
                                      'Add Comment',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ): Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex :3,
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: CommentController,
                                        cursorColor: Colors.black,
                                        maxLines: 4,
                                        maxLength: 1500,
                                        decoration: InputDecoration(
                                          filled: true,
                                          hintText: 'Add Comment',
                                          fillColor:
                                          Theme.of(context).scaffoldBackgroundColor,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          color: Colors.pink,
                                          onPressed: () async{
                                            // final FirebaseAuth auth = FirebaseAuth.instance;
                                            // final User? user = auth.currentUser;
                                            // final _uid= user!.uid;
                                            final generid= Uuid().v4();
                                            await FirebaseFirestore.instance.collection('Tasks').doc(widget.taskid).
                                            update({
                                              'Comment' : FieldValue.arrayUnion([{
                                                'name': authername,
                                                'time': Timestamp.now(),
                                                'userid' : widget.Userid ,
                                                'commentid': generid,
                                                'commentbody': CommentController.text,
                                                'imageusercomment': authorimage,
                                              }]),
                                            });
                                            Fluttertoast.showToast(
                                                msg: "comment has been uploaded successfully ",
                                                toastLength: Toast.LENGTH_LONG,
                                                // gravity: ToastGravity.CENTER,
                                                backgroundColor: Colors.amber,
                                                textColor: Colors.pink,
                                                fontSize: 14.0
                                            );
                                            CommentController.clear();
                                            setState(() {

                                            });
                                          },
                                          child: Text(
                                            'Post',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              comment =! comment;
                                            });
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          AddComment(taskid: widget.taskid,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        fallback: (context){
          return Center(child: CircularProgressIndicator(color: Colors.amber,));
        }
    );
  }
}
