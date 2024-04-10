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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<void> _handleRegistration() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    print("Registering with: $name, $email, $password"); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(165, 221, 155, 1.0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Register',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 62.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 98),
            CustomTextField(
              icon: Icons.person,
              label: 'Your name',
              hidden: false,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(222, 216, 109,1),
              controller: nameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              icon: Icons.email,
              label: 'Your email',
              hidden: false,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(93, 93, 93, 1),
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              icon: Icons.lock,
              label: 'Create Password',
              hidden: true,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(93, 93, 93, 1),
              controller: passwordController,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'REGISTER',
              onPressed: () {
                register_function(nameController.text, nameController.text, emailController.text,  passwordController.text, "image", "Male", 1.75, 80, "BULK", 1);
                _handleRegistration();
              },
              buttonWidth: MediaQuery.of(context).size.width * 0.5,
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
