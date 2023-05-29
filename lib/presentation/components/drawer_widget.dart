import 'package:firebase_app/presentation/components/show_diolge.dart';
import 'package:firebase_app/presentation/views/add_task.dart';
import 'package:firebase_app/presentation/views/all_worker_view.dart';
import 'package:firebase_app/presentation/views/home_view.dart';
import 'package:firebase_app/presentation/views/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/login_view.dart';
import '../views/my_account_view.dart';

class DrawerWidget extends StatelessWidget {
   DrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20)),

            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/image/3.jpg', ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Work OS', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            //  child: Decoration();
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeView()));

            },
            leading: Icon(Icons.task),
            title: Text('All Task', style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),),
          ),
          ListTile(
            onTap: (){
              final FirebaseAuth auth = FirebaseAuth.instance;
              final User? user = auth.currentUser;
              final _uid= user!.uid;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  MyAccountView(UserId: _uid,)));

            },
            leading: Icon(Icons.account_circle),
            title: Text('My Account', style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AllWorkerView()));

            },
            leading: Icon(Icons.workspaces_outline),
            title: Text('Registerd Works', style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTaskView()));
            },
            leading: Icon(Icons.add_card_rounded),
            title: Text('Add Task', style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.4 , color: Colors.amber)),
            ),
          ),
          ListTile(
            onTap: (){
              ShowDiolge(
                context: context,
                title: Row(
                  children: [
                    Icon(Icons.logout_outlined),
                    Text('Sign Out' , style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),

                  ],
                ),
                content: Text('Do You Wanna Sign Out' , style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),),
                  action: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text('Close', style: TextStyle(
                          color: Colors.amber
                      ),),
                    ),
                    TextButton(
                      onPressed: ()async{
                        final FirebaseAuth auth = FirebaseAuth.instance;

                        await auth.signOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context)=>UserState()),
                        );
                     // Navigator.pop(context) ;

                      },
                      child: Text('OK' , style: TextStyle(
                        color: Colors.red
                      ),),
                    ),
                  ]
              );
            },
            leading: Icon(Icons.logout),
            title: Text('Logout', style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),),
          ),
        ],
      ),
    );
  }
}
