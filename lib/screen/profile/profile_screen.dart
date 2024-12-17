import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/profile/widget/profile_card.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavBar(currentIndex: 4),
        body: Stack(children: [
          ListView(children: [
            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 28,
                          ),
                          Row(
                            children: [
                              InkWell(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(4, 4)),
                                      ]),
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundImage: userData?['userData']
                                                ['profilePhoto'] !=
                                            null
                                        ? NetworkImage(
                                            userData?['userData']
                                                ['profilePhoto'],
                                          )
                                        : const AssetImage(
                                            "assets/images/avatar_1.png",
                                          ) as ImageProvider,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        // width: 140,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(27),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/icons/text.png',
                                                  color: Colors.white,
                                                  width: 16,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .translate(
                                                          '${userData?['userData']['selectedbadges']}'),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Clash Grotesk',
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        width: 63,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(27),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Center(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/LeadIcon.png'),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    '${userData?['userData']['badgeNumber']}',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Clash Grotesk',
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 227,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(27),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icons/Lead Icon.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                            Center(
                                              child: Text(
                                                '${AppLocalizations.of(context).translate('Flyer type')}: ${userData?['userData']['flyertype']}',
                                                style: TextStyle(
                                                    fontFamily: 'Clash Grotesk',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 21,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${userData?['userData']['name']}',
                              style: const TextStyle(
                                fontFamily: 'Clash Grotesk',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${userData?['userData']['bio']}',
                              style: const TextStyle(
                                fontFamily: 'Clash Grotesk',
                                letterSpacing: 0.6,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('My favorite Airline is'),
                                  style: const TextStyle(
                                    fontFamily: 'Clash Grotesk',
                                    letterSpacing: 0.3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  ' ${userData?['userData']['favoriteAirlines']}',
                                  style: const TextStyle(
                                    fontFamily: 'Clash Grotesk',
                                    letterSpacing: 0.3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('Points received:'),
                                  style: const TextStyle(
                                    fontFamily: 'Clash Grotesk',
                                    letterSpacing: 0.3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "  ${userData?['userData']["points"]}",
                                  style: const TextStyle(
                                    fontFamily: 'Clash Grotesk',
                                    letterSpacing: 0.3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    const Divider(
                      thickness: 4,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    ProfileCardList(),
                  ],
                ),
              ],
            ),
          ]),
        ]),
      ),
    );
  }
}
