import 'package:airline_app/screen/profile/widget/card_airport.dart';
import 'package:airline_app/screen/profile/widget/card_bookmark.dart';
import 'package:airline_app/screen/profile/widget/card_chart.dart';
import 'package:airline_app/screen/profile/widget/card_map.dart';
import 'package:airline_app/screen/profile/widget/card_notifications.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/cairport_list_json.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback myfun;
  final int count;

  const ProfileCard({
    Key? key,
    required this.iconPath,
    required this.isActive,
    required this.count,
    required this.myfun,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.myfun, // Call the passed function when tapped
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
            ),
          ],
          color: widget.isActive
              ? AppStyles.mainButtonColor
              : Colors.white, // Change color based on active state
          borderRadius: BorderRadius.circular(36),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.iconPath,
                height: 24,
                width: 24,
              ),
              // Space between icon and count
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCardList extends StatefulWidget {
  @override
  State<ProfileCardList> createState() => _ProfileCardListState();
}

class _ProfileCardListState extends State<ProfileCardList> {
  int? _selectedIndex; // Track the selected index

  void _selectedCard(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> iconPaths = [
      "assets/icons/text.png",
      "assets/icons/trophy.png",
      "assets/icons/pin.png",
      "assets/icons/alt.png",
      "assets/icons/gear.png",
      // Add more icons as needed
    ];

    final List<Widget> PCardList = [
      SingleChildScrollView(child: CLeaderboardScreen()),
      CairMap(),
      Column(
        children: [
          SizedBox(
            height: 24,
          ),
          SingleChildScrollView(child: CardChart()),
        ],
      ),
      CardBookMark(),
      CardNotifications(),
      // Add more cards as needed
    ];

    return Column(
      children: [
        Container(
            width: 352,
            height: 78,
            decoration: BoxDecoration(
              border: Border.all(),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(iconPaths.length, (index) {
                  return ProfileCard(
                    count: index, // Pass the index as count
                    iconPath: iconPaths[index],
                    isActive:
                        _selectedIndex == index, // Check if this card is active
                    myfun: () =>
                        _selectedCard(index), // Pass the select function
                  );
                }),
              ),
            )),

        // Check if _selectedIndex is not null before accessing PCardList
        if (_selectedIndex != null && _selectedIndex! < PCardList.length)
          PCardList[_selectedIndex!] // Use ! to assert it is not null
        else
          Container(), // Fallback widget when no card is selected
      ],
    );
  }
}
