

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String Function(T?)? displayText;
  final void Function(T?)? onChanged;
  final TextEditingController controller;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    this.value,
    this.displayText,
    this.onChanged,
    required this.controller
  }) : super(key: key);

  @override
  _CustomDropdownButtonState<T> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 180, // Adjust the height as needed
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        widget.displayText?.call(widget.items[index]) ??
                            widget.items[index].toString(),
                        style: const TextStyle(
                          fontFamily: 'Signika',
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedValue = widget.items[index];
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget.items[index]);
                        }
                        Navigator.pop(context); 
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(93, 93, 93, 1), 
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: const Color.fromRGBO(93, 93, 93, 1),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.displayText?.call(_selectedValue) ??
                  _selectedValue.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                fontFamily: 'Signika',
                color: Colors.white,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool hidden;
  final Color borderColor;
  Color fillColor;
  TextEditingController controller;

  CustomTextField({super.key, required this.icon, required this.label, required this.hidden, required this.borderColor, required this.fillColor, required this.controller});

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

