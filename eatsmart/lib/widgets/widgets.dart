

import 'package:flutter/material.dart';



class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hidden;
  final Color borderColor;
  Color fillColor;
  TextEditingController controller;

  CustomTextField({required this.icon, required this.label, required this.hidden, required this.borderColor, required this.fillColor, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: borderColor), 
        prefixIcon: Icon(icon, color: borderColor),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0), 
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0), 
      ),
      obscureText: hidden,
      style: TextStyle(
        fontFamily: 'Signika',
        color: borderColor, 
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;  

  CustomButton({required this.text, required this.onPressed, required this.buttonHeight, required this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Signika',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

