import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_bitcoin/BitcoinScreen.dart'; 

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: 'BITCOIN CRYPTOCURRENCY', 
      theme: ThemeData(),
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
       MaterialPageRoute(builder: (content)=>const BitcoinScreen()))
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Image.asset('assets/images/bitcoin_main.jpg', scale: 1),
              const SizedBox(height: 10.0),
              const Text("BITCOIN CRYPTOCURRENCY CONVERTER",
              style: TextStyle(
                fontSize:25, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center
              )
            ],
          ),
        ));
      }
    }