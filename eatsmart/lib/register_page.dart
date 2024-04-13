
// ignore_for_file: empty_catches

import 'dart:ffi';

import 'package:eatsmart/widgets/widgets.dart';
import 'package:eatsmart/account_backend/register.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userHeighController = TextEditingController();
  final userWeightController = TextEditingController();
  final userSexController = TextEditingController();
  final userObjectiveController = TextEditingController();
  double userHeigh = 0;
  double userWeight = 0;
  
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    userHeighController.dispose();
    userWeightController.dispose();
    super.dispose();
  }
  Future<void> _handleRegistration() async {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String userHeight = userHeighController.text;
    String userWeight = userWeightController.text;
    String userSex = userSexController.text;
    String userObjective = userObjectiveController.text;
    print("Registering with: $firstName, $lastName, $email, $password, $userHeight, $userWeight, $userSex, $userObjective"); 
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(165, 221, 155, 1.0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.09),
            Text(
              'Register',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 62.0,
              ),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: screenHeight * 0.09),
            CustomTextField(
              icon: Icons.person,
              label: 'First name',
              hidden: false,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(222, 216, 109,1),
              controller: firstNameController,
            ),
             SizedBox(height: screenHeight * 0.02),
            CustomTextField(
              icon: Icons.person,
              label: 'Last name',
              hidden: false,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(222, 216, 109,1),
              controller: lastNameController,
            ),
             SizedBox(height: screenHeight * 0.02),
            CustomTextField(
              icon: Icons.email,
              label: 'Your email',
              hidden: false,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(93, 93, 93, 1),
              controller: emailController,
            ),
             SizedBox(height: screenHeight * 0.02),
            CustomTextField(
              icon: Icons.lock,
              label: 'Create Password',
              hidden: true,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(93, 93, 93, 1),
              controller: passwordController,
            ),
             SizedBox(height: screenHeight * 0.02),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.4, // Set the width as needed
                      child:CustomDropdownButton<String>(
                      items:  List.generate(200, (index) => "${((index + 100) / 100).toStringAsFixed(2)} cm"),
                      value: "Height",
                      controller: userHeighController,
                      onChanged: (value){
                        setState(() {
                          userHeighController.text = value ?? '';
                        });
                      },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth*0.02,),
                Column(children: [
                    SizedBox(
                      width: screenWidth * 0.4, // Set the width as needed
                      child:CustomDropdownButton<String>(
                      items:   List.generate(342, (index) =>'${(30 + (index * 0.5)).toStringAsFixed(1)} kg'),
                      value: "Weight",
                      controller: userWeightController,
                      onChanged: (value){
                        setState(() {
                          userWeightController.text = value ?? '';
                        });
                      },
                      ),
                    ),
                  ],
                ),
              ],
            ),
             SizedBox(height: screenHeight * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Column(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.4, // Set the width as needed
                      child: CustomDropdownButton<String>(
                        items: const ['Male', 'Female'],
                        value: "Sex",
                        controller: userSexController,
                        onChanged: (value){
                        setState(() {
                          userSexController.text = value ?? '';
                        });
                      },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth*0.02,),
                 Column(children: [
                    SizedBox(
                      width: screenWidth * 0.4, // Set the width as needed
                      child: CustomDropdownButton<String>(
                      items: const ['BULK', 'CUT', 'MAINTAIN'],
                      value: "Objective",
                      controller: userObjectiveController,
                      onChanged: (value){
                        setState(() {
                          userObjectiveController.text = value ?? '';
                        });
                      },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: screenHeight * 0.03),
            CustomButton(
              text: 'REGISTER',
              onPressed: () {
                try{
                  userHeigh = double.parse((userHeighController.text).substring(0,4));
                  userWeight = double.parse((userWeightController.text).replaceAll(' kg', ''));
                }catch (e){}
                register_function(firstNameController.text, lastNameController.text, emailController.text,  passwordController.text, "image", userSexController.text, userHeigh, userWeight, userObjectiveController.text, 1);
                _handleRegistration();

              },
              buttonWidth: screenWidth * 0.5,
              buttonHeight: 50.0,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Assuming this would go back to the login screen
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
