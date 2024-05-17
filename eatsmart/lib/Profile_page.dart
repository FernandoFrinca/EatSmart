import 'package:eatsmart/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:eatsmart/account_backend/global.dart';
import 'package:eatsmart/account_backend/profile_data.dart';
import 'package:eatsmart/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? firstName; 
  String? lastName; 
  String? profilePicture; 

  @override
  void initState() {
    super.initState();
    showName(); 
  }

  Future<void> showName() async {
    int userID = getID(); 
    String? fetchedfirstName = await get_firstName(userID); 
    String? fetchedlastName = await get_lastName(userID);
    String? fetchedImage = await get_image(userID);
    
    if (mounted) { 
      setState(() {
        firstName = fetchedfirstName;
        lastName = fetchedlastName;
        profilePicture = fetchedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.15),
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/$profilePicture.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                lastName ?? 'Loading...',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                firstName ?? 'Loading...',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              MenuItem(
                icon: Icons.edit,
                title: 'Edit Profile',
                iconSize: 30.0,
                textSize: 18.0,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen()),
                  ).then((_) {
                    showName();
                  });
                  print('Edit Profile tapped');
                },
                height: screenHeight * 0.06,
                width: screenWidth * 0.85,
              ),
              MenuItem(
                icon: Icons.lock,
                title: 'Terms & Privacy Policy',
                iconSize: 30.0,
                textSize: 18.0,
                onTap: () {
                  print('Terms & Privacy Policy tapped');
                },
                height: screenHeight * 0.06,
                width: screenWidth * 0.85,
              ),
              MenuItem(
                icon: Icons.exit_to_app,
                title: 'Log Out',
                iconSize: 30.0,
                textSize: 18.0,
                onTap: () {
                  print('Log Out tapped');
                },
                height: screenHeight * 0.06,
                width: screenWidth * 0.85,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
