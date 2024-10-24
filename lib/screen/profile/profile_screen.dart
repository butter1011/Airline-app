import 'package:airline_app/screen/profile/utils/profile_buttonList_json.dart';
import 'package:airline_app/screen/profile/widget/card_chart.dart';
import 'package:airline_app/screen/profile/widget/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          height: 60,
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
                                    AssetImage('assets/images/avatar1.png'),
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
                  Container(
                    width: 352,
                    height: 78,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(3, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: profile_buttonList.map((profilevalue) {
                          return ProfileCard(
                            iconPath: profilevalue["imagePath"],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
              SingleChildScrollView(child: CardChart()),
            ],
          ),
        ]),
        Positioned(
            bottom: 0,
            height: 30,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
            )),
        Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Divider(
                    thickness: 3,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
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
                                'assets/icons/chart.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          Container(
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
                                'assets/icons/ai.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: Color.fromARGB(
                                255,
                                63,
                                234,
                                156,
                              ),
                              borderRadius: BorderRadius.circular(36),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/plus.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          Container(
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
                                'assets/icons/check.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(36),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/user.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
