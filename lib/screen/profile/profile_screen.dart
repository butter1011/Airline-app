import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Stack(
        children: [
          // Background Image
          // Image.asset(
          //   'assets/images/Finnair.png', // Replace with your image asset
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   width: double.infinity,
          // ),
          // Gradient Overlay
          Container(
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.transparent, // No color at the top
                  Colors.black
                      .withOpacity(0.8), // Gradient color from 30px downwards
                ],
                stops: [
                  0.1,
                  1
                ], // Adjust stops to control where the gradient starts and ends
              ),
            ),
            // Start the gradient 30px from the top
          ),
        ],
      ),
    );
  }
}
