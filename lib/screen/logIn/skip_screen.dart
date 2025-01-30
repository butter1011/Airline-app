import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SkipScreen extends StatefulWidget {
  const SkipScreen({super.key});

  @override
  State<SkipScreen> createState() => _SkipScreenState();
}

class _SkipScreenState extends State<SkipScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final List bottomSheetList = [
      _firstBottomSheet(),
      _secondBottomSheet(),
      _thirdBottomSheet(),
    ];
    final List titleList = [
      "Unbiased Reviews",
      "Shareed Flight Feedback",
      "Real-Time Insights"
    ];
    final List contentList = [
      // "Explore real, verified reviews to help you make informed travel choices ",
      // "Your voice matters! Share your experiences and help improve air travel for everyone",
      // "Stay updated and share feedback while you're still in the moment"
      "Explore real, verified reviews to help you make informed travel choices",
      "Your voice matters! Share your experiences and help improve air travel for everyone",
      "Stay updated and share feedback while you're still in the moment"
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(
                    //         'assets/images/popup_${selectedIndex + 1}.png'),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ),
                  Positioned(
                      left: 87,
                      top: 60,
                      right: 113,
                      child: Image.asset(
                        'assets/images/skipscreen${selectedIndex}.png',
                        width: 175,
                        height: 155,
                      )),
                  Positioned(
                      left: 0,
                      top: 278,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          width: screenSize.width - 70,
                          child: selectedIndex == 0
                              ? _buildTextFieldFirst()
                              : selectedIndex == 1
                                  ? _buildTextFieldSecond()
                                  : _buildTextFieldThird(),
                        ),
                      )),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: screenSize.height * 0.37,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 4,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Color(0xff97A09C),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              height: 27,
                            ),
                            Text(
                              titleList[selectedIndex],
                              style: AppStyles.textStyle_24_600.copyWith(
                                fontFamily: 'Clash Grotesk',
                              ),
                            ),
                            SizedBox(
                              height: 42,
                            ),
                            Text(
                              contentList[selectedIndex],
                              style: AppStyles.textStyle_15_400.copyWith(
                                color: Color(0xff38433E),
                                fontFamily: 'Clash Grotesk',
                              ),
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "1",
                                    style: AppStyles.textStyle_24_600.copyWith(
                                        color: selectedIndex == 0
                                            ? Colors.black
                                            : AppStyles.mainColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Image.asset(
                                      "assets/images/baggage_black.png"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "2",
                                    style: AppStyles.textStyle_24_600.copyWith(
                                        color: selectedIndex == 1
                                            ? Colors.black
                                            : AppStyles.mainColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Image.asset("assets/images/flight_black.png"),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "3",
                                    style: AppStyles.textStyle_24_600.copyWith(
                                        color: selectedIndex == 2
                                            ? Colors.black
                                            : AppStyles.mainColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: bottomSheetList[selectedIndex]);
  }

  Widget _firstBottomSheet() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Container(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: _NavigationButton(
                        onTap: () {
                          setState(() {
                            selectedIndex = (selectedIndex + 1) % 3;
                          });
                        },
                        buttonName: "Next",
                        color: Colors.white))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _secondBottomSheet() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Container(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: _NavigationButton(
                        onTap: () {
                          setState(() {
                            selectedIndex = (selectedIndex + 1) % 3;
                          });
                        },
                        buttonName: "Next",
                        color: Colors.white))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _thirdBottomSheet() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Container(
            height: 2,
            color: Colors.black,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _NavigationButton(
                onTap: () {
                  selectedIndex = (selectedIndex + 1) % 3;
                  Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
                },
                buttonName: "Get Started",
                color: AppStyles.backgroundColor),
          )
        ],
      ),
    );
  }

  Widget _buildTextFieldFirst() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exp Feedback',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w700,
            fontSize: selectedIndex == 0
                ? 40
                : selectedIndex == 1
                    ? 50
                    : 65,
            color: Colors.black,
          ),
        ),
        Text(
          'that takes',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: selectedIndex == 0
                ? 40
                : selectedIndex == 1
                    ? 50
                    : 65,
            color: Colors.black,
          ),
        ),
        Text(
          'Flight',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w700,
            fontSize: selectedIndex == 0
                ? 40
                : selectedIndex == 1
                    ? 50
                    : 65,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _buildTextFieldSecond() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exp',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w700,
            fontSize: 50,
            color: Colors.black,
          ),
        ),
        Text(
          'Feedback',
          style: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.w700,
              fontSize: 50,
              color: Colors.black,
              height: 0.7),
        ),
        Text(
          'that takes',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 50,
            // height: 0.7,
            color: Colors.black,
          ),
        ),
        Text(
          'Flight',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w700,
            fontSize: 50,
            height: 0.7,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget _buildTextFieldThird() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exp',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w700,
            fontSize: 65,
            color: Colors.black,
          ),
        ),
        Text(
          'Feedback',
          style: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.w700,
              fontSize: 65,
              color: Colors.black,
              height: 0.7),
        ),
        Text(
          'that takes',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 65,
            // height: 0.7,
            color: Colors.black,
          ),
        ),
        Text(
          'Flight',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w700,
            fontSize: 65,
            height: 0.7,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton(
      {required this.onTap, required this.buttonName, required this.color});
  final VoidCallback onTap;
  final String buttonName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: AppStyles.buttonDecoration
            .copyWith(color: color, borderRadius: BorderRadius.circular(28)),
        child: Center(
          child: Text(
            buttonName,
            style: AppStyles.textStyle_15_600,
          ),
        ),
      ),
    );
  }
}
