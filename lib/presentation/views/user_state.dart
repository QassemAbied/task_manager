import 'package:firebase_app/presentation/views/home_view.dart';
import 'package:firebase_app/presentation/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseAuth.instance.authStateChanges() ,
      builder: (context , userSnapshot){
        if(userSnapshot.data==null){
          return LoginView();
        }else if(userSnapshot.hasData){
          return HomeView();
        }else if(userSnapshot.hasError){
          return Scaffold(
            body: Text('WE FOUND ERROR',
              style: TextStyle(
                fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            ),
            ),
          );
        }
        return Scaffold(
          body: Text('WE FOUND ERROR',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
