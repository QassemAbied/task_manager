import 'package:firebase_app/presentation/views/login_view.dart';
import 'package:firebase_app/presentation/views/user_state.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserState()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(
                  'assets/image/7.jpg',
                ),
               fit: BoxFit.fitWidth,
              )),
          Text(
            'Work Management',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 0.2,
                  color: Colors.blueGrey.shade400,
                  offset: Offset.fromDirection(100),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
