import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String iconPath;

  const ProfileCard({Key? key, required this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(3, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Center(
        child: Image.asset(
          '$iconPath',
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
