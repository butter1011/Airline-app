import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.black, offset: Offset(2, 2)),
                  ]),
                  child: const CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage('assets/images/avatar1.png'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
