import 'package:airline_app/screen/profile/widget/card_airport.dart';
import 'package:airline_app/screen/profile/widget/card_bookmark.dart';
import 'package:airline_app/screen/profile/widget/card_chart.dart';
import 'package:airline_app/screen/profile/widget/card_map.dart';
import 'package:airline_app/screen/profile/widget/card_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/screen/profile/widget/profile_card1.dart';
import 'package:airline_app/screen/profile/widget/profile_card2.dart';
import 'package:airline_app/screen/profile/widget/profile_card3.dart';
import 'package:airline_app/screen/profile/widget/profile_card4.dart';
import 'package:airline_app/screen/profile/widget/profile_card5.dart';

// Define the StateProvider for selected index
final selectedIndexProvider =
    StateProvider<int>((ref) => 0); // Default value is 0

class ProfileCardList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex =
        ref.watch(selectedIndexProvider); // Watch the provider directly

    final List<String> iconPaths = [
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              boxShadow: [
                BoxShadow(color: Colors.black, offset: Offset(2, 2)),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileCard1(
                    count: 0,
                    iconPath: iconPaths[0],
                    isActive: selectedIndex == 0,
                    myfun: () => ref
                        .read(selectedIndexProvider.notifier)
                        .state = 0, // Update state
                  ),
                  ProfileCard2(
                    count: 1,
                    iconPath: iconPaths[1],
                    isActive: selectedIndex == 1,
                    myfun: () =>
                        ref.read(selectedIndexProvider.notifier).state = 1,
                  ),
                  ProfileCard3(
                    count: 2,
                    iconPath: iconPaths[2],
                    isActive: selectedIndex == 2,
                    myfun: () =>
                        ref.read(selectedIndexProvider.notifier).state = 2,
                  ),
                  ProfileCard4(
                    count: 3,
                    iconPath: iconPaths[3],
                    isActive: selectedIndex == 3,
                    myfun: () =>
                        ref.read(selectedIndexProvider.notifier).state = 3,
                  ),
                  ProfileCard5(
                    count: 4,
                    iconPath: iconPaths[4],
                    isActive: selectedIndex == 4,
                    myfun: () =>
                        ref.read(selectedIndexProvider.notifier).state = 4,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Check if selectedIndex is valid before accessing PCardList
        if (selectedIndex < PCardList.length)
          PCardList[selectedIndex]
        else
          PCardList[0], // Fallback widget when no card is selected
      ],
    );
  }
}
