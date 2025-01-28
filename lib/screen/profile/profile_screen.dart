import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/app_widgets/bottom_nav_bar.dart';
import 'package:airline_app/screen/profile/widget/card_airport.dart';
import 'package:airline_app/screen/profile/widget/card_bookmark.dart';
import 'package:airline_app/screen/profile/widget/card_chart.dart';
import 'package:airline_app/screen/profile/widget/card_map.dart';
import 'package:airline_app/screen/profile/widget/card_notifications.dart';
import 'package:airline_app/screen/profile/widget/profile_card.dart';
import 'package:airline_app/screen/profile/widget/profile_card5.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool showEditIcon = false;

  void toggleEditIcon() {
    setState(() {
      showEditIcon = !showEditIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final List<dynamic> iconPaths = [
      "assets/icons/text.png",
      "assets/icons/pin.png",
      "assets/icons/trophy.png",
      "assets/icons/alt.png",
      "assets/icons/gear.png",
    ];
    final List<Widget> PCardList = [
      SingleChildScrollView(child: CLeaderboardScreen()),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 24),
            Container(
              height: 558,
              decoration: AppStyles.cardDecoration,
              child: MapScreen(),
            ),
            SizedBox(height: 13),
          ],
        ),
      ),
      Column(
        children: [
          SizedBox(height: 24),
          CardChart(),
        ],
      ),
      CardBookMark(),
      CardNotifications(),
    ];

    final userData = ref.watch(userDataProvider);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavBar(currentIndex: 3),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: toggleEditIcon,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(4, 4)),
                                      ]),
                                  child: CircleAvatar(
                                    radius: 50,
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
                              ProfileCard5(
                                count: 4,
                                iconPath: iconPaths[4],
                                isActive: selectedIndex == 4,
                                myfun: () => ref
                                    .read(selectedIndexProvider.notifier)
                                    .state = 4,
                              ),
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
                                fontFamily: 'clash Grotesk',
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
                                    fontFamily: 'inter',
                                    letterSpacing: 0.3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  ' ${userData?['userData']['favoriteAirlines']}',
                                  style: const TextStyle(
                                    fontFamily: 'inter',
                                    letterSpacing: 0.3,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 1),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/Lead Icon.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${AppLocalizations.of(context).translate('Flyer type')}: ${userData?['userData']['flyertype']}',
                                          style: TextStyle(
                                              fontFamily: 'inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                    if (selectedIndex < PCardList.length)
                      PCardList[selectedIndex]
                    else
                      PCardList[0]
                  ],
                ),
              ],
            ),
          ]),
          if (showEditIcon)
            Positioned(
              top: 100,
              left: 70,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.eidtprofilescreen);
                  toggleEditIcon();
                },
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
 // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         AppLocalizations.of(context)
                          //             .translate('Points received:'),
                          //         style: const TextStyle(
                          //           fontFamily: 'inter',
                          //           letterSpacing: 0.3,
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //       ),
                          //       Text(
                          //         "  ${userData?['userData']["points"]}",
                          //         style: const TextStyle(
                          //           fontFamily: 'inter',
                          //           letterSpacing: 0.3,
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
 // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Row(
                              //       children: [
                              //         // InkWell(
                              //         //   onTap: () => ref
                              //         //       .read(
                              //         //           selectedIndexProvider.notifier)
                              //         //       .state = 2,
                              //         //   child: Container(
                              //         //     height: 32,
                              //         //     decoration: BoxDecoration(
                              //         //       border: Border.all(),
                              //         //       color: Colors.black,
                              //         //       borderRadius:
                              //         //           BorderRadius.circular(27),
                              //         //     ),
                              //         //     child: Padding(
                              //         //       padding: const EdgeInsets.symmetric(
                              //         //           horizontal: 10.0),
                              //         //       child: Center(
                              //         //         child: Row(
                              //         //           mainAxisAlignment:
                              //         //               MainAxisAlignment.center,
                              //         //           children: [
                              //         //             Image.asset(
                              //         //               'assets/icons/text.png',
                              //         //               color: Colors.white,
                              //         //               width: 16,
                              //         //               height: 16,
                              //         //             ),
                              //         //             const SizedBox(width: 8),
                              //         //             Text(
                              //         //               AppLocalizations.of(context)
                              //         //                   .translate(
                              //         //                       '${userData?['userData']['selectedbadges']}'),
                              //         //               style: TextStyle(
                              //         //                   fontFamily:
                              //         //                       'inter',
                              //         //                   fontSize: 16,
                              //         //                   color: Colors.white,
                              //         //                   fontWeight:
                              //         //                       FontWeight.w500),
                              //         //             ),
                              //         //           ],
                              //         //         ),
                              //         //       ),
                              //         //     ),
                              //         //   ),
                              //         // ),
                              //         const SizedBox(
                              //           width: 8,
                              //         ),
                              //         Container(
                              //           width: 63,
                              //           height: 32,
                              //           decoration: BoxDecoration(
                              //             border: Border.all(),
                              //             color: Colors.black,
                              //             borderRadius:
                              //                 BorderRadius.circular(27),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.black,
                              //                 offset: Offset(2, 2),
                              //               ),
                              //             ],
                              //           ),
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(1.0),
                              //             child: Center(
                              //               child: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.center,
                              //                   children: [
                              //                     Image.asset(
                              //                         'assets/icons/LeadIcon.png'),
                              //                     SizedBox(
                              //                       width: 4,
                              //                     ),
                              //                     Text(
                              //                       '${userData?['userData']['badgeNumber']}',
                              //                       style: TextStyle(
                              //                           fontFamily: 'inter',
                              //                           fontSize: 16,
                              //                           color: Colors.white,
                              //                           fontWeight:
                              //                               FontWeight.w500),
                              //                     ),
                              //                   ]),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //     const SizedBox(
                              //       height: 8,
                              //     ),
                              //   ],
                              // )
