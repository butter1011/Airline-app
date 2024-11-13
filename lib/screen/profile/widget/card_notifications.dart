import 'dart:ui';

import 'package:airline_app/screen/profile/widget/basic_button%20english.dart';

import 'package:airline_app/screen/profile/widget/basic_language_button.dart';

import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CardNotifications extends StatefulWidget {
  const CardNotifications({super.key});

  @override
  State<CardNotifications> createState() => _CardNotificationsState();
}

class _CardNotificationsState extends State<CardNotifications> {
  String _selectedLanguage = 'English';
  void _changeLanguageFun(String language) {
    setState(() {
      _selectedLanguage = language; // Update selected language
    });
    // Call your modal bottom sheet or any other functionality here
    // showModalBottomSheet(...);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.cardnotificationscreen,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications (5)',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.profilesupportscreen,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contact Support',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.cardnotificationscreen,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calendar Sync',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.eidtprofilescreen,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.cardnotificationscreen,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Help & FAQs',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.aboutapp,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'About the App',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.termsofservice,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Terms of Service',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'App Language',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _changeLanguageFun('English');
                  // Navigator.pushNamed(context, AppRoutes.aboutapp);
                  _changeLanguage(context);
                },
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'English'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: "English"),
              ),
              InkWell(
                onTap: () {
                  _changeLanguageFun('Chinese');
                  // Navigator.pushNamed(context, AppRoutes.aboutapp);
                  _changeLanguage(context);
                },
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'Chinese'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: "Chinese"),
              ),
              InkWell(
                onTap: () {
                  _changeLanguageFun('Russian');
                  // Navigator.pushNamed(context, AppRoutes.aboutapp);
                  _changeLanguage(context);
                },
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'Russian'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: "Russian"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   AppRoutes.cardnotificationscreen,
              // );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sign Out',
                  style: TextStyle(
                      fontFamily: 'Clash Grotesk',
                      fontSize: 20,
                      color: Color(0xFF181818),
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  'assets/icons/rightarrow.png',
                  width: 40,
                  height: 40,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }

  Future _changeLanguage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Blurred background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            // Modal content
            Container(
              height: 181,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 32,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Change to ${_selectedLanguage}",
                      style: AppStyles.textStyle_24_600
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Are you sure you want to change to Chinese?",
                      style: AppStyles.textStyle_14_400,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2, color: Colors.black),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.profilescreen);
                          },
                          child: BasicLanguageButton(
                            mywidth: 155,
                            myheight: 56,
                            myColor: Colors.white,
                            btntext: "No, leave",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Implement language change logic here
                            Navigator.pop(context);
                          },
                          child: BasicLanguageButton(
                            mywidth: 155,
                            myheight: 56,
                            myColor: AppStyles.mainColor,
                            btntext: "Yes, change",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
