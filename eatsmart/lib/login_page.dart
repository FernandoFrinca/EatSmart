
import 'package:eatsmart/Home_page.dart';
import 'package:eatsmart/account_backend/login.dart';
import 'package:eatsmart/register_page.dart';
import 'package:eatsmart/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   bool flagLogin = false;

  Future<bool> _handleLOGIN() async {
    String email = emailController.text;
    String password = passwordController.text;
    print(emailController.text);
    print("Logined with: $email, $password");
    flagLogin = await login_function(emailController.text, passwordController.text);
    if (flagLogin) {
      setState(() {
        flagLogin = false;
      });
      return true;
    } else {
      setState(() {
        flagLogin = true;
      });
      return true;
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              'Eat Smart',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 62.0, 
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 98),
            CustomTextField(
              icon: Icons.email,
              label: 'Your email',
              hidden: false,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor:  const Color.fromRGBO(222, 216, 109,1), 
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              icon: Icons.lock,
              label: 'Password',
              hidden: true,
              borderColor: const Color.fromRGBO(255, 255, 255, 1),
              fillColor: const Color.fromRGBO(93, 93, 93, 1),
              controller: passwordController,
            ),
            Center(
              child: Visibility(
                visible: flagLogin, 
                child: const Text(
                  'Wrong Password or Email',
                  style: TextStyle(
                    color: Colors.red, 
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24,),
            CustomButton(
              text: 'Log in',
              onPressed: () async {
                if(await _handleLOGIN()){
                      Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              },
             buttonWidth: MediaQuery.of(context).size.width * 0.5,
             buttonHeight: 50.0
            ),
            TextButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, 
              ),
              child: const Text("Don't have an account?"),
            ),
          ],
        ),
      ),
    );
  }
}