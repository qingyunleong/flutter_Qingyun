import 'dart:async';

import 'package:bmi/bmical.dart';
import 'package:flutter/material.dart'; 

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'Flutter Demo', 
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        ),
        home: const SplashScreen(),
      );
    }
  }

  class SplashScreen extends StatefulWidget {
    const SplashScreen({Key? key}) : super(key: key);
  
    @override
    State<SplashScreen> createState() => _SplashScreenState();
  }
  
  class _SplashScreenState extends State<SplashScreen> {
    @override

    void initState() {
      super.initState();
      Timer(const Duration (seconds: 3), ()=> 
      Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (content)=> BmiScreen()))
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Image.asset('assets/image/bmical.png', scale: 2),
              const Text("BMI CALCULATOR",
              style: TextStyle(
                fontSize:32, fontWeight: FontWeight.bold, color: Colors.red),
              )
            ],
          ),
        ));
      }
    }