

// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, sized_box_for_whitespace

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
  final Color borderColor; 
  final Color fillColor;
  final Color textColor;  
  final Color popupTextColor; 
  final Color popupBackgroundColor; 
  final double width;  
  final double height; 

  const CustomDropdownButton({
    super.key,
    required this.items,
    this.value,
    this.displayText,
    this.onChanged,
    required this.controller,
    required this.borderColor,
    required this.fillColor,
    this.textColor = Colors.black,
    this.popupTextColor = Colors.black, 
    this.popupBackgroundColor = Colors.white, 
    this.width = double.infinity,
    this.height = 50.0, 
  });

  @override
  _CustomDropdownButtonState<T> createState() => _CustomDropdownButtonState<T>();
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
              backgroundColor: widget.popupBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 180,
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        widget.displayText?.call(widget.items[index]) ??
                            widget.items[index].toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: widget.popupTextColor,
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
        width: widget.width, 
        height: widget.height, 
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: widget.borderColor,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.displayText?.call(_selectedValue) ??
                  _selectedValue.toString(),
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Signika',
                color: widget.textColor,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: widget.textColor),
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
  final Color fillColor;
  final TextEditingController controller;
  final bool isEnabled; 

  CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.hidden,
    required this.borderColor,
    required this.fillColor,
    required this.controller,
    this.isEnabled = true, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: hidden,
      enabled: isEnabled, 
      style: TextStyle(
        fontFamily: 'Signika',
        color: borderColor,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: borderColor),
        prefixIcon: Icon(icon, color: borderColor),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: borderColor, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
      ),
    );
  }
}


class CustomDropdownButtonFetched<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String Function(T?)? displayText;
  final void Function(T?)? onChanged;
  final Color borderColor;
  final Color fillColor;
  final Color textColor;
  final Color popupTextColor;
  final Color popupBackgroundColor;

  const CustomDropdownButtonFetched({
    super.key,
    required this.items,
    this.value,
    this.displayText,
    this.onChanged,
    required this.borderColor,
    required this.fillColor,
    this.textColor = Colors.black,
    this.popupTextColor = Colors.black,
    this.popupBackgroundColor = Colors.white,
  });

  @override
  _CustomDropdownButtonFetchedState<T> createState() => _CustomDropdownButtonFetchedState<T>();
}

class _CustomDropdownButtonFetchedState<T> extends State<CustomDropdownButtonFetched<T>> {
  T? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.value; 
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: currentValue,
      items: widget.items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(widget.displayText?.call(value) ?? value.toString(),
              style: TextStyle(color: widget.textColor)),
        );
      }).toList(),
      onChanged: (T? newValue) {
        if (newValue != null) {
          setState(() {
            currentValue = newValue;
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          });
        }
      },
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

class CustomCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final double width; 
  final double height; 

  const CustomCard({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
    this.color = const Color.fromRGBO(229, 243, 228, 1),
    this.textColor = Colors.black,
    this.iconColor = Colors.black54,
    this.width = 80, 
    this.height = 100, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: color,
        elevation: 0,
        child: Container(
          width: width, 
          height: height, 
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Icon(iconData, color: iconColor, size: 24), 
              const SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(
                  color: textColor, 
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCardButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;

  const CustomCardButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = 200.0, 
    this.height = 50.0, 
    this.fontSize = 16.0, 
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF6D365),
              Color(0xFFFDA085),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.arrow_forward,
              color: Colors.black,
              size: 24.0, 
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final double width;
  final double height;
  final ImageProvider image;  
  final String title;  
  final String buttonText;  
  final VoidCallback onPressed;  
  final Color backgroundColor;  
  final Color buttonColor;  

  const InfoCard({
    super.key,
    this.width = 350,
    this.height = 200,
    required this.image,
    this.title = "A new way to live healthy", 
    this.buttonText = "Read Now", 
    required this.onPressed,
    this.backgroundColor = Colors.white, 
    this.buttonColor = Colors.amber, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: onPressed,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(buttonColor), 
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 120,
                width: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}


//Profile page widgets 

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final double iconSize;
  final double textSize;
  final double? height;
  final double? width;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconSize = 24.0,  
    this.textSize = 16.0, 
    this.height,  
    this.width,   
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ListTile(
        leading: Icon(icon, color: Colors.orange, size: iconSize),  
        title: Text(title, style: TextStyle(fontSize: textSize)),  
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),  
        onTap: onTap,
      ),
    );
  }
}
