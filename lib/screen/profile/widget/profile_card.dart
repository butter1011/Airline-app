import 'package:airline_app/screen/profile/widget/card_airport.dart';
import 'package:airline_app/screen/profile/widget/card_bookmark.dart';
import 'package:airline_app/screen/profile/widget/card_chart.dart';
import 'package:airline_app/screen/profile/widget/card_map.dart';
import 'package:airline_app/screen/profile/widget/card_notifications.dart';
import 'package:airline_app/screen/profile/widget/profile_card1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/screen/profile/widget/profile_card5.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class ProfileCardList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ProfileCard1(
            //   iconPath: iconPaths[0],
            //   isActive: selectedIndex == 0,
            //   count: 0,
            //   myfun: () => ref.read(selectedIndexProvider.notifier).state = 0,
            // ),
            ProfileCard5(
              count: 4,
              iconPath: iconPaths[4],
              isActive: selectedIndex == 4,
              myfun: () => ref.read(selectedIndexProvider.notifier).state = 4,
            ),
          ],
        ),
      ],
    );
  }
}
