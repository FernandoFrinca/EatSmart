import 'package:eatsmart/login_page.dart';
import 'package:eatsmart/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eat Smart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontFamily: 'Signika', fontWeight: FontWeight.bold),
        ),
      ),
      home: LoginScreen(),
    );
  }
}


