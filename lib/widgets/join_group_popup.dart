import 'package:flutter/material.dart';

class JoinGroupPopup extends StatelessWidget {
  const JoinGroupPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: screenHeight * 0.4, // popup yüksekliği
        width: screenWidth * 0.3, // popup genişliği
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter a group code", style: TextStyle(fontSize: 20)),
              SizedBox(height: screenHeight * 0.02),
              Card(
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(onPressed: () {}, child: Text("Join")),
            ],
          ),
        ),
      ),
    );
  }
}
