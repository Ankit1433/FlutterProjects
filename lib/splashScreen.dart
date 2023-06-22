import 'dart:async';
import 'package:covideapp/main.dart';
import 'package:covideapp/view/world_states.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    {
  
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () { 
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => WorldStates(),));
      }
      );
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body:Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/data.json'),
                  const Text("Covid-19\nTracker App",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                ],
        )
      )
    );
  }
}