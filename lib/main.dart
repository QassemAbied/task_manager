import 'package:firebase_app/presentation/state_mangement/login/login_bloc.dart';
import 'package:firebase_app/presentation/views/splash_screen.dart';
import 'package:firebase_app/presentation/views/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  ServiceLocator().init();
  runApp(
      MultiBlocProvider(
          providers: [
          BlocProvider(
          create: (BuildContext context)=>Sl<LoginBloc>(),),
          ],
      child : MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,
        //primaryColor: Colors.white,
      ),
      home:SplashScreen(),
    );
  }
}

