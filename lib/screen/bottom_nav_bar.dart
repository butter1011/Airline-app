import 'package:airline_app/screen/chatbot/chatbot_screen.dart';
import 'package:airline_app/screen/feed/feed_screen.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_home.dart/leaderboard_screen.dart';
import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/screen/reviewsubmission/reviewsubmission_screen.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // List of widgets for each tab
  final List<Widget> _pages = [
    LeaderboardScreen(),
    ChatbotScreen(),
    ReviewsubmissionScreen(),
    FeedScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _selectedIndex == 1
          ? Text('')
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  color: Colors.black,
                ),
                BottomNavigationBar(
                  backgroundColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Container(
                        width: 59,
                        height: 59,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 0
                              ? AppStyles.littleBlackColor
                              : AppStyles
                                  .whiteColor, // Background color for the container
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 2, color: AppStyles.littleBlackColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyles
                                  .littleBlackColor, // Adjust opacity if needed
                              offset: const Offset(2, 2),
                              // blurRadius: 4, // Add blur radius for a smoother shadow
                            ),
                          ], // Rounded corners
                        ),

                        child: _selectedIndex == 0
                            ? Image.asset('assets/icons/leaderboard_white.png')
                            : Image.asset(
                                'assets/icons/leaderboard.png'), // Icon inside the container
                      ),
                      label: 'Leaderboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        width: 59,
                        height: 59,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 1
                              ? AppStyles.littleBlackColor
                              : AppStyles
                                  .whiteColor, // Background color for the container
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 2, color: AppStyles.littleBlackColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyles
                                  .littleBlackColor, // Adjust opacity if needed
                              offset: const Offset(2, 2),
                              // blurRadius: 4, // Add blur radius for a smoother shadow
                            ),
                          ], // Rounded corners
                        ),

                        child: _selectedIndex == 1
                            ? Image.asset('assets/icons/ai_white.png')
                            : Image.asset(
                                'assets/icons/ai.png'), // Icon inside the container
                      ),
                      label: 'Ai Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        width: 59,
                        height: 59,
                        decoration: BoxDecoration(
                          color: AppStyles
                              .mainButtonColor, // Background color for the container
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 2, color: AppStyles.littleBlackColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyles
                                  .littleBlackColor, // Adjust opacity if needed
                              offset: const Offset(2, 2),
                              // blurRadius: 4, // Add blur radius for a smoother shadow
                            ),
                          ], // Rounded corners
                        ),

                        child: Image.asset(
                            'assets/icons/plus.png'), // Icon inside the container
                      ),
                      label: 'Review',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        width: 59,
                        height: 59,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 3
                              ? AppStyles.littleBlackColor
                              : AppStyles
                                  .whiteColor, // Background color for the container
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 2, color: AppStyles.littleBlackColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyles
                                  .littleBlackColor, // Adjust opacity if needed
                              offset: const Offset(2, 2),
                              // blurRadius: 4, // Add blur radius for a smoother shadow
                            ),
                          ], // Rounded corners
                        ),

                        child: _selectedIndex == 3
                            ? Image.asset('assets/icons/star_white.png')
                            : Image.asset(
                                'assets/icons/star.png'), // Icon inside the container
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        width: 59,
                        height: 59,
                        decoration: BoxDecoration(
                          color: _selectedIndex == 4
                              ? AppStyles.littleBlackColor
                              : AppStyles
                                  .whiteColor, // Background color for the container
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 2, color: AppStyles.littleBlackColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppStyles
                                  .littleBlackColor, // Adjust opacity if needed
                              offset: const Offset(2, 2),
                              // blurRadius: 4, // Add blur radius for a smoother shadow
                            ),
                          ], // Rounded corners
                        ),
                        child: _selectedIndex == 4
                            ? Image.asset('assets/icons/profile_white.png')
                            : Image.asset(
                                'assets/icons/profile.png'), // Icon inside the container
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  onTap: _onItemTapped,
                ),
              ],
            ),
    );
  }
}
