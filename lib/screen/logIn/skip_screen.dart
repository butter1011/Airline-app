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
   
    final List bottomSheetList = [
      _firstBottomSheet(),
      _secondBottomSheet(),
      _thirdBottomSheet(),
    ];
    final List titleList = [
      "Unbiased Reviews",
      "Share Flight Feedback",
      "Real-Time Insights"
    ];
    final List contentList = [
      "Explore real, verified reviews to help you make informed travel choices ",
      "Your voice matters! Share your experiences and help improve air travel for everyone",
      "Stay updated and share feedback while you're still in the moment"
    ];

    return Scaffold(
        backgroundColor: AppStyles.mainColor,
        body: Center(
          child: Column(
            children: [
              // Wrap Stack in SizedBox to give it a fixed height
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.63, // Set an appropriate height
                child: Stack(
                  children: [
                    // Background Image
                    Positioned(
                      top: -96, // Adjust this value to move the image higher
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 575,
                        height: 575,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/skip_plane.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // You can add more widgets here if needed
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24))),
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
                            style: AppStyles.textStyle_24_600,
                          ),
                          SizedBox(
                            height: 42,
                          ),
                          Text(
                            contentList[selectedIndex],
                            style: AppStyles.textStyle_15_400.copyWith(
                              color: Color(0xff38433E),
                            ),
                          ),
                          SizedBox(
                            height: 21,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  width: 9,
                                  height: 9,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Color(0xff2c2c2c)),
                                    color: selectedIndex == index
                                        ? Color(0xff2cfff6)
                                        : Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    )),
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
                          Navigator.pushNamed(
                              context, AppRoutes.leaderboardscreen);
                        },
                        buttonName: "Skip",
                        color: Colors.white)),
                SizedBox(
                  width: 16,
                ),
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
                          Navigator.pushNamed(
                              context, AppRoutes.leaderboardscreen);
                        },
                        buttonName: "Skip",
                        color: Colors.white)),
                SizedBox(
                  width: 16,
                ),
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
                color: AppStyles.mainColor),
          )
        ],
      ),
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
