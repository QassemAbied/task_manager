
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_app/domain/entities/user_enitites.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_bloc.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_event.dart';
import 'package:firebase_app/presentation/state_mangement/login/login_state.dart';
import 'package:firebase_app/presentation/views/login_view.dart';
import 'package:firebase_app/presentation/views/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/di.dart';

class MyAccountView extends StatefulWidget {
  const MyAccountView({Key? key,required this.UserId }) : super(key: key);
  final String UserId;
  @override
  State<MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {

  final FirebaseFirestore firestore= FirebaseFirestore.instance;
    String name ='';
   String email ='';
   String userImageUrl='';
   String phoneNuber='';
   String positionCompany='';
   String createdAt='';
   String id='';


    bool isSameUser= false;
  final FirebaseAuth auth = FirebaseAuth.instance;


  void getUserData()async{

    final DocumentSnapshot userDoc = await firestore.collection('User').doc(widget.UserId).get();
    if(userDoc == null){
      return ;
    }else{

      setState(() {
        name = userDoc.get('name');
        email= userDoc.get('email');
        phoneNuber = userDoc.get('phoneNuber');
        userImageUrl = userDoc.get('userImageUrl');
        Timestamp joinedTmestamp = userDoc.get('createdAt');
        final joinatData = joinedTmestamp.toDate();
        createdAt= '${joinatData.year}-${joinatData.month}-${joinatData.day}';
        positionCompany= userDoc.get('positionCompany');
      });
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final _uid= user!.uid;
      setState(() {
        isSameUser= _uid == widget.UserId;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
        return  ConditionalBuilder(
          condition: userImageUrl.isNotEmpty,
          builder: (context){
            return  Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 150 , right: 10 , left: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.white54,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(name==null?'': name,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('$positionCompany $createdAt',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.pink,
                                ),),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 0.5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Contact Info :',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Text('   ',
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Text('Email :',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Text(email==null?'': email,
                                        style:  TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.pink,
                                        ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Text('Phone Number :',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Text(phoneNuber==null? '':phoneNuber ,
                                        style:  TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.pink,
                                        ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                               isSameUser? Container():   Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleIcon(
                                        context,
                                        Colors.pink,
                                            () {
                                          _launchUrlmail();
                                        },
                                        Icons.email_outlined,
                                      ),
                                      CircleIcon(

                                        context,
                                        Colors.amber,(){
                                        _launchUrlwatsapp();
                                      },
                                       FontAwesome5.whatsapp,
                                      ),
                                      CircleIcon(
                                        context,
                                        Colors.teal,
                                            () {
                                          _launchUrlphone();},
                                        Icons.phone,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                 !isSameUser?Container(): Center(
                                    child: Container(
                                      width: 110.0,
                                      height: 40.0,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        color: Colors.pink,
                                        onPressed: ()async {
                                          await auth.signOut();
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context)=> UserState()));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.logout_outlined,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Logout',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                // decoration: TextDecoration.underline,
                                              ),
                                            ),

                                          ],

                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                      ),
                    ),
                    Positioned(
                      top: 115,
                      left: 130,
                      child: Container(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 35,
                            //backgroundImage: NetworkImage(userImageUrl==null?'': userImageUrl, ),
                            child: CachedNetworkImage(
                              imageUrl:userImageUrl==null?'': userImageUrl,
                              imageBuilder: (context , ImageProvider){
                                return CircleAvatar(
                                  radius: 35,
                                  backgroundImage: ImageProvider,
                                );
                              },
                              placeholder: (context , child){
                                return  CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage('assets/image/3.jpg'),
                                );
                                //return Image(image: AssetImage('assets/image/3.jpg'));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
          fallback: (context){
            return Center(child: CircularProgressIndicator(color: Colors.amber,),);
          },
        );

  }
  Widget CircleIcon(context , Color radius1 ,Function ftx, IconData icon) {
    return CircleAvatar(
      backgroundColor: radius1,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        child: IconButton(
          onPressed: () {
            ftx();
          },
          icon: Icon(icon, color: radius1,),
        ),
      ),
    );
  }
  Future<void> _launchUrlwatsapp() async {
    //String phoneNamer = '01150038250';
    final Uri _url = Uri.parse('https://wa.me/$phoneNuber/text=qaseem');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch ');
    }
  }
  Future<void> _launchUrlphone() async {
//String phoneNamer = '01150038250';
    final Uri _url = Uri.parse('tel://$phoneNuber');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch ');
    }
  }


  Future<void> _launchUrlmail() async {
    final Uri _url = Uri.parse('mailto:$email');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch ');
    }
  }


}

