import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: screenWidth * 0.09,
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 89, 30, 253),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(110, 0, 0, 0),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(widget.text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
