import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/screen/profile/widget/basic_black_button.dart';
import 'package:airline_app/screen/profile/widget/basic_button.dart';

import 'package:airline_app/utils/app_styles.dart';

import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 66,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfileScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/left.png', // Path to your arrow icon
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: Text('Notifications',
                            style: AppStyles.textStyle_16_600))),
              ],
            ),
          ),
          Divider(
            thickness: 4,
            color: Colors.black,
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Type',
                  style: AppStyles.textStyle_18_600,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: [
              BasicButton(
                  mywidth: 49,
                  myheight: 40,
                  myColor: AppStyles.mainColor,
                  btntext: "All"),
              BasicButton(
                  mywidth: 112,
                  myheight: 40,
                  myColor: Colors.white,
                  btntext: "Promotional"),
              BasicButton(
                  mywidth: 83,
                  myheight: 40,
                  myColor: Colors.white,
                  btntext: "Reward"),
              BasicButton(
                  mywidth: 96,
                  myheight: 40,
                  myColor: Colors.white,
                  btntext: "Feedback"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(
              thickness: 2,
              color: Colors.black,
            ),
          ),
          Container(
            width: 327,
            decoration: AppStyles.notificationDecoration,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'E-mail Sync',
                        style: AppStyles.textStyle_16_600,
                      ),
                      Icon(Icons.arrow_forward_sharp)
                    ],
                  ),
                  Text(
                    'Sub headline goes here where we explain the why we need it',
                    style: AppStyles.textStyle_14_600.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BasicBlackButton(
                        mywidth: 126,
                        myheight: 24,
                        myColor: Colors.black,
                        btntext: 'Recommended',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width: 327,
            decoration: AppStyles.notificationDecoration,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'E-mail Sync',
                        style: AppStyles.textStyle_16_600,
                      ),
                      Icon(Icons.arrow_forward_sharp)
                    ],
                  ),
                  Text(
                    'Sub headline goes here where we explain the why we need it',
                    style: AppStyles.textStyle_14_600.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BasicBlackButton(
                        mywidth: 126,
                        myheight: 24,
                        myColor: Colors.black,
                        btntext: 'Recommended',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
