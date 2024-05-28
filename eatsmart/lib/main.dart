// ignore_for_file: use_key_in_widget_constructors
import 'package:eatsmart/Home_page.dart';
import 'package:eatsmart/Profile_page.dart';
import 'package:eatsmart/login_page.dart';
import 'package:eatsmart/pantry_page.dart';
import 'package:eatsmart/scan_page.dart';
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
      home: const LoginScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => MainPage();
}

class MainPage extends State<MainScreen> {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    BarcodeScannerPage(),
    const HomeScreen(),
    const PantryScreen(),
    const ProfileScreen(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _widgetOptions
              .elementAt(_selectedIndex)), 
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        backgroundColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 227, 232, 227),
        selectedItemColor: const Color.fromRGBO(165, 221, 155, 1.0),
        iconSize: 30,
        selectedFontSize: 15,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Pantry',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

