import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/domain/entities/add_task_entities.dart';
import 'package:firebase_app/presentation/components/constance.dart';
import 'package:firebase_app/presentation/components/drawer_widget.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_bloc.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_event.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../components/show_diolge.dart';
import '../components/textfromfield_widget.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key }) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final categoryController = TextEditingController();
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final deadlineDataController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    deadlineDataController.dispose();
  }
  final FormKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Timestamp? _deadlineDatatimeStamp;
  DateTime? Picked;
 bool isLoading = false;
  void Uploaded(){
    final vaild = FormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(vaild){
      try{
        setState(() {
          isLoading=true;
        });
        final User? user = auth.currentUser;
        final _uid= user!.uid;
        final taskID= Uuid().v4();

        BlocProvider.of<LoginBloc>(context)..add(
            setAddTaskUserEvent(addTskEntities:
            AddTskEntities(
              taskCategory: categoryController.text,
              taskTitle: taskTitleController.text,
              taskDescription: taskDescriptionController.text,
              deadlineData: deadlineDataController.text,
              upLoaded:_uid,
              Comment: [],
              isDone: false,
              CreatedAt: Timestamp.now(),
              deadlineDatatimeStamp: _deadlineDatatimeStamp,
              taskID: taskID,
            )));
        Fluttertoast.showToast(
            msg: "Taskhas been upLoaded Successfuly",
            toastLength: Toast.LENGTH_LONG,
           // gravity: ToastGravity.CENTER,
           backgroundColor: Colors.amber,
            textColor: Colors.pink,
            fontSize: 14.0
        );
        categoryController.clear();
        taskTitleController.clear();
        taskDescriptionController.clear();
        deadlineDataController.clear();
      }catch(error){
        setState(() {
          isLoading=false;
        });
      }finally{
        setState(() {
          isLoading=false;
        });
      }
    }else{
      setState(() {
        isLoading=false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc , LoginStates>(
      builder: (context , state){
        return  Scaffold(
          drawer: Drawer(
            child: DrawerWidget(),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Add Tasks',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Card(
                elevation: 0.1,
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 10, left: 10),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'All Field Are Require',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Task Category*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        GestureDetector(
                          onTap: (){
                            ShowDiolge(
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
                                                  categoryController.text = Constances.Category[index];
                                                  Navigator.pop(context);
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

                                ]
                            );
                          },
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            controller: categoryController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Field is a Massing';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabled: false,
                              filled: true,
                              hintText: 'Task Category',
                              fillColor: Theme.of(context).scaffoldBackgroundColor,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Task Title*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          maxLines: 1,
                          maxLength: 100,
                          controller: taskTitleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Field is a Massing';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Task Title',
                            fillColor: Theme.of(context).scaffoldBackgroundColor,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Task Description*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          maxLines: 4,
                          maxLength: 1500,
                          controller: taskDescriptionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Field is a Massing';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Task Description',
                            fillColor: Theme.of(context).scaffoldBackgroundColor,
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Deadline data*',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.pink,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        GestureDetector(
                          onTap: (){
                            ShowTimeDate(context);


                          },
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            controller: deadlineDataController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Field is a Massing';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabled: false,
                              filled: true,
                              hintText: 'Pick Up a Data ',
                              fillColor: Theme.of(context).scaffoldBackgroundColor,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                     isLoading? Center(child: CircularProgressIndicator(color: Colors.amber,),):
                     Center(
                          child: Container(
                            width: 110.0,
                            height: 40.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.pink,
                              onPressed: () {
                                Uploaded();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Upload',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  Icon(
                                    Icons.upload,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  void ShowTimeDate(context ) async{
   Picked= await  showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(21200),
    ) ;
   if(Picked !=null){
     setState(() {
       _deadlineDatatimeStamp = Timestamp.fromMicrosecondsSinceEpoch(Picked!.microsecondsSinceEpoch);
       deadlineDataController.text = '${Picked!.year} -${Picked!.month} -${Picked!.day}';
     });
   }
   return null;


  }
}


