import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final color;
  final textcolor;
  final String buttonText;
  final buttonTaped;

  const Button({
    super.key,
    required this.color,
    required this.textcolor,
    required this.buttonText,
    this.buttonTaped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTaped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textcolor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
