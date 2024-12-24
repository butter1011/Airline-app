import 'dart:ui';
import 'package:airline_app/main.dart';
import 'package:airline_app/provider/selected_language_provider.dart';
import 'package:airline_app/screen/profile/widget/basic_button%20english.dart';
import 'package:airline_app/screen/profile/widget/basic_language_button.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardNotifications extends ConsumerStatefulWidget {
  @override
  ConsumerState<CardNotifications> createState() => _CardNotificationsState();
}

class _CardNotificationsState extends ConsumerState<CardNotifications> {
  String _selectedLanguage = 'English';
  String _selectedLanguageSym = 'en';

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  void _loadLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
      _selectedLanguageSym = prefs.getString('selectedLanguageSym') ?? 'en';
    });
  }

  Future<void> _showSignOutConfirmation(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
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
                      AppLocalizations.of(context).translate("Sign Out"),
                      style: AppStyles.textStyle_24_600
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("Are you sure you want to sign out?"),
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
                            Navigator.pop(context);
                          },
                          child: BasicLanguageButton(
                            mywidth: 155,
                            myheight: 56,
                            myColor: Colors.white,
                            btntext: AppLocalizations.of(context)
                                .translate("Cancel"),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            // Delete token from SharedPreferences
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('token');
                            await prefs.remove('userData');

                            // Close the modal bottom sheet
                            Navigator.pop(context);

                            // Navigate to login screen and remove all previous routes
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.loginscreen,
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: BasicLanguageButton(
                            mywidth: 155,
                            myheight: 56,
                            myColor: AppStyles.mainColor,
                            btntext: AppLocalizations.of(context)
                                .translate("Sign Out"),
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
        // ... (rest of the UI code remains the same)
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
        //   child: InkWell(
        //     onTap: () {
        //       Navigator.pushNamed(
        //         context,
        //         AppRoutes.calendersyncscreen,
        //       );
        //     },
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           AppLocalizations.of(context).translate('Calendar Sync'),
        //           style: TextStyle(
        //               fontFamily: 'Clash Grotesk',
        //               fontSize: 20,
        //               color: Color(0xFF181818),
        //               fontWeight: FontWeight.w600),
        //         ),
        //         Image.asset(
        //           'assets/icons/rightarrow.png',
        //           width: 40,
        //           height: 40,
        //         )
        //       ],
        //     ),
        //   ),
        // ),
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
                onTap: () => _changeLanguage(context, 'English', 'en'),
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'English'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: AppLocalizations.of(context).translate("English")),
              ),
              InkWell(
                onTap: () => _changeLanguage(context, 'Chinese', 'zh'),
                child: BasicButtonEnglish(
                    mywidth: 103,
                    myheight: 40,
                    myColor: _selectedLanguage == 'Chinese'
                        ? AppStyles.mainColor
                        : Colors.white,
                    btntext: AppLocalizations.of(context).translate("Chinese")),
              ),
              InkWell(
                onTap: () => _changeLanguage(context, 'Russian', 'ru'),
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
              _showSignOutConfirmation(context);
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

  Future<void> _changeLanguage(
      BuildContext context, String language, String lSym) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
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
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            setState(() {
                              _selectedLanguage = language;
                              _selectedLanguageSym = lSym;
                            });
                            await prefs.setString('selectedLanguage', language);
                            await prefs.setString('selectedLanguageSym', lSym);

                            ref.read(localeProvider.notifier).state =
                                Locale('$_selectedLanguageSym', '');
                            ref
                                .read(selectedLanguageProvider.notifier)
                                .changeLanguage(_selectedLanguage);

                            await prefs.setString(
                                'selectedLanguage', _selectedLanguage);
                            await prefs.setString(
                                'selectedLanguageSym', _selectedLanguageSym);
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
