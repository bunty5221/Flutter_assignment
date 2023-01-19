import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fullapp/view/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override void initState() {

    
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topRight,
          end: Alignment.bottomRight,

              colors: [Colors.indigo,
              Colors.indigoAccent]

          )

        ),
        child: Center(child: Text("flutter assignment",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)),
      ),

    );
  }
}
