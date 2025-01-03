
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
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
        Navigator.pushNamed(context, AppRoutes.startreviews);
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
    final userData = ref.watch(userDataProvider);

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
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: AppStyles.littleBlackColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppStyles.littleBlackColor,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: _selectedIndex == 0
                    ? Image.asset('assets/icons/leaderboard_white.png')
                    : Image.asset('assets/icons/leaderboard.png'),
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
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: AppStyles.littleBlackColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppStyles.littleBlackColor,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: _selectedIndex == 1
                    ? Image.asset('assets/icons/ai_white.png')
                    : Image.asset('assets/icons/ai.png'),
              ),
              label: 'Ai Chat',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 59,
                height: 59,
                decoration: BoxDecoration(
                  color: AppStyles.mainColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: AppStyles.littleBlackColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppStyles.littleBlackColor,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Image.asset('assets/icons/plus.png'),
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
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: AppStyles.littleBlackColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppStyles.littleBlackColor,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: _selectedIndex == 3
                    ? Image.asset('assets/icons/message_white.png')
                    : Image.asset('assets/icons/message.png'),
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
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2, color: AppStyles.littleBlackColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppStyles.littleBlackColor,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: userData?['userData']['profilePhoto'] != null
                      ? NetworkImage(userData?['userData']['profilePhoto'])
                      : const AssetImage("assets/images/avatar_1.png")
                          as ImageProvider,
                ),
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
