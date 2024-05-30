// ignore_for_file: avoid_print
import 'dart:io';

import 'package:eatsmart/generateMenu.dart';
import 'package:eatsmart/menuGenerator/juice.dart';
import 'package:eatsmart/menuGenerator/meat.dart';
import 'package:eatsmart/menuGenerator/pasta.dart';
import 'package:eatsmart/menuGenerator/salad.dart';
import 'package:eatsmart/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

void _launchURL() async {
  const url = 'https://www.healthyfood.com/';
  
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Eat Smart',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: const Color.fromRGBO(165, 221, 155, 1.0),
                        fontSize: 62.0,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                InfoCard(
                  width: screenWidth * 0.9, 
                  height: screenHeight * 0.25, 
                  image: const AssetImage('images/work.jpg'), 
                  title: 'Discover Healthy Living',
                  buttonText: 'Explore Now', 
                  backgroundColor: const Color(0xfffff8eb),
                  buttonColor: const Color(0xfff2c18d), 
                  onPressed: _launchURL,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCardButton(
                  label: 'Generate a menu',
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateMenu()),
                    );
                  },
                  width: screenWidth * 0.92, 
                  height: screenHeight * 0.12, 
                  fontSize: 18.0,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04), 
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: const Text(
                "Choose Your Favorites",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), 
            SizedBox(
              height: screenHeight * 0.17,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CustomCard(
                    // iconData: Icons.local_dining, 
                    text: 'Salad',
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GenerateMenuSalad()),
                    );
                    },
                    color: Colors.orange.shade100,
                    textColor: Colors.orange.shade900,
                    iconColor: Colors.orange.shade600,
                    width: 120,
                    height: 120,
                    imageProvider: AssetImage('images/salad2.gif'), 
                  ),
                  CustomCard(
                    //iconData: Icons.local_dining,
                    text: 'Meat',
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GenerateMenuMeat()),
                    );
                    },
                    color: Colors.lightGreen.shade100,
                    textColor: Colors.green.shade900,
                    iconColor: Colors.green.shade600,
                    width: 120,
                    height: 120,
                    imageProvider: AssetImage('images/grill.gif'),
                  ),
                  CustomCard(
                    //iconData: Icons.local_dining,
                    text: 'Pasta',
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GenerateMenuPasta()),
                    );
                    },
                    color: Colors.orange.shade100,
                    textColor: Colors.orange.shade900,
                    iconColor: Colors.orange.shade600,
                    width: 120,
                    height: 120,
                    imageProvider: AssetImage('images/pasta.gif'),
                  ),
                  CustomCard(
                    //iconData: Icons.local_dining,
                    text: 'Juice',
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GenerateMenuJuice()),
                    );
                    },
                    color: Colors.lightGreen.shade100,
                    textColor: Colors.green.shade900,
                    iconColor: Colors.green.shade600,
                    width: 120,
                    height: 120,
                    imageProvider: AssetImage('images/juice.gif'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
