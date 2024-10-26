import 'package:airline_app/screen/bottom_nav_bar.dart';
import 'package:airline_app/screen/profile/widget/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(currentIndex: 4),
      body: Stack(children: [
        ListView(children: [
          Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(4, 4)),
                                  ]),
                              child: const CircleAvatar(
                                radius: 36,
                                backgroundImage:
                                    AssetImage('assets/images/avatar_1.png'),
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
                                      width: 140,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(27),
                                      ),
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
                                            Text(
                                              ' Top Reviewer',
                                              style: TextStyle(
                                                  fontFamily: 'Clash Grotesk',
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      width: 43,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(27),
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
                                          child: Text(
                                            '+9',
                                            style: TextStyle(
                                                fontFamily: 'Clash Grotesk',
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
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
                                    border: Border.all(),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(27),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(4, 4),
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
                                            child: const Text(
                                              'Flyer type: Business Class',
                                              style: const TextStyle(
                                                  fontFamily: 'Clash Grotesk',
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Benedict Cumberbatch',
                            style: TextStyle(
                              fontFamily: 'Clash Grotesk',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Very long bio goes here pushing it to the second row',
                            style: TextStyle(
                              fontFamily: 'Clash Grotesk',
                              letterSpacing: 0.3,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'My favorite Airline is',
                                style: TextStyle(
                                  fontFamily: 'Clash Grotesk',
                                  letterSpacing: 0.3,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                '  British Airways',
                                style: TextStyle(
                                  fontFamily: 'Clash Grotesk',
                                  letterSpacing: 0.3,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                'Point received:',
                                style: TextStyle(
                                  fontFamily: 'Clash Grotesk',
                                  letterSpacing: 0.3,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                '  500',
                                style: TextStyle(
                                  fontFamily: 'Clash Grotesk',
                                  letterSpacing: 0.3,
                                  height: 1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
                    height: 24,
                  ),
                  ProfileCardList(),
                ],
              ),
            ],
          ),
        ]),
      ]),
    );
  }
}
