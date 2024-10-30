import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedIndex with the currentIndex passed from the widget
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
      case 1:
        Navigator.pushNamed(context, AppRoutes.chatbotscreen);
      case 2:
        Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
      case 3:
        Navigator.pushNamed(context, AppRoutes.feedscreen);
      case 4:
        Navigator.pushNamed(context, AppRoutes.profilescreen);

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      : Colors.white, // Background color for the container
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
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
                      : Colors.white, // Background color for the container
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
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
                  color:
                      AppStyles.mainColor, // Background color for the container
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
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
                      : Colors.white, // Background color for the container
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
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
                    ? Image.asset('assets/icons/message_white.png')
                    : Image.asset(
                        'assets/icons/message.png'), // Icon inside the container
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
                      : Colors.white, // Background color for the container
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(width: 2, color: AppStyles.littleBlackColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppStyles
                          .littleBlackColor, // Adjust opacity if needed
                      offset: const Offset(2, 2),
                      // blurRadius: 4, // Add blur radius for a smoother shadow
                    ),
                  ], // Rounded corners
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar_1.png'),
                ), // Icon inside the container
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
    );
  }
}
