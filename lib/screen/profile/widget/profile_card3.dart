import 'package:airline_app/utils/app_styles.dart';

import 'package:flutter/material.dart';

class ProfileCard3 extends StatefulWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback myfun;
  final int count;

  const ProfileCard3({
    Key? key,
    required this.iconPath,
    required this.isActive,
    required this.count,
    required this.myfun,
  }) : super(key: key);

  @override
  State<ProfileCard3> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard3> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.myfun, // Call the passed function when tapped
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
            ),
          ],
          color: widget.isActive
              ? AppStyles.mainColor
              : Colors.white, // Change color based on active state
          borderRadius: BorderRadius.circular(36),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.iconPath,
                height: 24,
                width: 24,
              ),
              // Space between icon and count
            ],
          ),
        ),
      ),
    );
  }
}
