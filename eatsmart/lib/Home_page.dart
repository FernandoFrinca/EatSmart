// ignore_for_file: avoid_print
import 'package:eatsmart/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
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
                  onPressed: () {
                    print('Button pressed!');
                  },
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
                    print('Button pressed!');
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
                    iconData: Icons.local_dining,
                    text: 'Salad',
                    onTap: () {
                      print('Salad card tapped!');
                    },
                    color: Colors.orange.shade100,
                    textColor: Colors.orange.shade900,
                    iconColor: Colors.orange.shade600,
                    width: 120,
                    height: 120,
                  ),
                  CustomCard(
                    iconData: Icons.local_dining,
                    text: 'Salad',
                    onTap: () {
                      print('Salad card tapped!');
                    },
                    color: Colors.lightGreen.shade100,
                    textColor: Colors.green.shade900,
                    iconColor: Colors.green.shade600,
                    width: 120,
                    height: 120,
                  ),
                  CustomCard(
                    iconData: Icons.local_dining,
                    text: 'Salad',
                    onTap: () {
                      print('Salad card tapped!');
                    },
                    color: Colors.orange.shade100,
                    textColor: Colors.orange.shade900,
                    iconColor: Colors.orange.shade600,
                    width: 120,
                    height: 120,
                  ),
                  CustomCard(
                    iconData: Icons.local_dining,
                    text: 'Salad',
                    onTap: () {
                      print('Salad card tapped!');
                    },
                    color: Colors.lightGreen.shade100,
                    textColor: Colors.green.shade900,
                    iconColor: Colors.green.shade600,
                    width: 120,
                    height: 120,
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
