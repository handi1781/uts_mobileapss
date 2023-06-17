import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_couse2/start_screen.dart';
import 'package:udemy_couse2/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var activeScreen = const StartScreen();

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 240, 243, 240),
          Color.fromARGB(218, 17, 235, 126)
        ])),
        child: activeScreen,
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}
