import 'package:eatsmart/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
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
            ),
            const SizedBox(height: 16),
            CustomTextField(
              icon: Icons.email,
              label: 'Your email',
              hidden: false,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(93, 93, 93, 1),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              icon: Icons.lock,
              label: 'Create Password',
              hidden: true,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(93, 93, 93, 1),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'REGISTER',
              onPressed: () {
                // Handle registration logic
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
