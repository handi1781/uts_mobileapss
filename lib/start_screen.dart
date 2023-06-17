import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:udemy_couse2/login.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 90,
        ),
        Opacity(
          opacity: 1,
          child: Image.asset(
            './assets/images/bonek11.png',
            width: 300,
          ),
        ),
        const SizedBox(height: 80),
        const SizedBox(height: 30),
        OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const content(),
              ));
            },
            style: OutlinedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 5, 71, 3),
                maximumSize: Size(600, 700)),
            icon: Icon(Icons.sports_soccer_outlined),
            label: Text('Klik')),
      ],
    ));
  }
}
