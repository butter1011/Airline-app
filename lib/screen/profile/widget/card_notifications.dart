import 'dart:ui';
import 'package:airline_app/main.dart';
import 'package:airline_app/screen/profile/widget/basic_button%20english.dart';

import 'package:airline_app/screen/profile/widget/basic_language_button.dart';
import 'package:airline_app/utils/app_localizations.dart';

import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardNotifications extends ConsumerStatefulWidget {
  @override
  ConsumerState<CardNotifications> createState() => _CardNotificationsState();
}

class _CardNotificationsState extends ConsumerState<CardNotifications> {
  String _selectedLanguage = 'English';
  String _selectedLanguageSym = 'en';
  void _changeLanguageFun(String language, String lSym) {
    setState(() {
      _selectedLanguage = language;
      _selectedLanguageSym = lSym;
      // Update selected language
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
                  AppLocalizations.of(context).translate('Notifications (5)'),
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
                  AppLocalizations.of(context).translate('Contact Support'),
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
                  AppLocalizations.of(context).translate('Calendar Sync'),
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
                  AppLocalizations.of(context).translate('Edit Profile'),
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
                AppRoutes.helpFaqs,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('Help & FAQs'),
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
                  AppLocalizations.of(context).translate("About the app"),
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
                  AppLocalizations.of(context).translate('Terms of Service'),
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
                  AppLocalizations.of(context).translate('App Language'),
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
                  _changeLanguageFun('English', 'en');

                  // Navigator.pushNamed(context, AppRoutes.aboutapp);
                  _changeLanguage(context);
                },
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'English'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: AppLocalizations.of(context).translate("English")),
              ),
              InkWell(
                onTap: () {
                  _changeLanguageFun('Chinese', 'zh');
                  // Navigator.pushNamed(context, AppRoutes.aboutapp);
                  _changeLanguage(context);
                },
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'Chinese'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: AppLocalizations.of(context).translate("Chinese")),
              ),
              InkWell(
                onTap: () {
                  _changeLanguageFun('Russian', 'ru');
                  // Navigator.pushNamed(context, AppRoutes.aboutapp);
                  _changeLanguage(context);
                },
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'Russian'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: AppLocalizations.of(context).translate("Russian")),
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
                  AppLocalizations.of(context).translate('Sign Out'),
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
              height: MediaQuery.of(context).size.height * 0.26,
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
                      AppLocalizations.of(context).translate(
                          "Change to ${_selectedLanguage}? Are you sure you want to change to ${_selectedLanguage}?"),
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
                            btntext: AppLocalizations.of(context)
                                .translate("No, leave"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ref.read(localeProvider.notifier).state = Locale(
                                '$_selectedLanguageSym',
                                ''); // Implement language change logic here
                            Navigator.pop(context);
                          },
                          child: BasicLanguageButton(
                            mywidth: 155,
                            myheight: 56,
                            myColor: AppStyles.mainColor,
                            btntext: AppLocalizations.of(context)
                                .translate("Yes, change"),
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

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(title ?? '')),
          const Text(' : '),
          Expanded(child: Text(content ?? '')),
        ],
      ),
    );
  }
}
