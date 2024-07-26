import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quicknote/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){ //init means initialize
    super.initState();
    Timer(
        Duration(seconds: 4), (){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => home_screen(),
          ));
    }
    );

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png',width: 200,height: 200,),
            SizedBox(
              height: 30,
            ),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
            SizedBox(
              height: 250,
            ),
            Center(child: Text('From',style: TextStyle(fontSize: 12,color: Colors.black,fontFamily: "avenir"),)),
            Center(child: Text('Eagedevnet',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black,fontFamily: "avenir"),)),
          ],
        ),
      ),
    );
  }
}
