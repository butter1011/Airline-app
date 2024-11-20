import 'dart:convert';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/screen/profile/widget/review_button.dart';
import 'package:airline_app/provider/selected_button_provider.dart';
import 'package:http/http.dart' as http;

class CardChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<CardChart> createState() => _CardChartState();
}

class _CardChartState extends ConsumerState<CardChart> {
  final List<Map<String, String>> buttons = [
    {'iconUrl': 'assets/icons/reviewmessage.png', 'label': 'Top Reviewer'},
    {'iconUrl': 'assets/icons/review_icon_comfort.png', 'label': 'Connoisseur'},
    {
      'iconUrl': 'assets/icons/review_icon_cleanliness.png',
      'label': 'Enthusiast'
    },
    {
      'iconUrl': 'assets/icons/review_icon_onboard.png',
      'label': 'Facility Virtuoso'
    },
    {'iconUrl': 'assets/icons/review_icon_food.png', 'label': 'Service Maven'},
    {
      'iconUrl': 'assets/icons/review_icon_entertainment.png',
      'label': 'Spotless Traveler'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedButtonIndex = ref.watch(selectedButtonProvider);

    List<Map<String, String>> sortedButtons = List.from(buttons);
    if (selectedButtonIndex != null) {
      final selectedButton = sortedButtons.removeAt(selectedButtonIndex);
      sortedButtons.insert(0, selectedButton);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: sortedButtons.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ReviewButton(
                  iconUrl: sortedButtons[index]['iconUrl']!,
                  label: AppLocalizations.of(context)!
                      .translate('${sortedButtons[index]['label']!}')
                      .toString(),
                  isSelected: selectedButtonIndex ==
                      buttons.indexOf(sortedButtons[index]),
                  onTap: () {
                    ref
                        .read(selectedButtonProvider.notifier)
                        .selectButton(buttons.indexOf(sortedButtons[index]));
                    _badgeFunction(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _badgeFunction(int index) async {
    final UserData = ref.watch(userDataProvider);

    final userInformationData =
        await http.post(Uri.parse('$apiUrl/api/v1/badgeEditUser'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'selectedbadges': buttons[index]['label']!,
              '_id': UserData?['userData']['_id'],
            }));

    if (userInformationData.statusCode == 200) {
      final responseChangeData = jsonDecode(userInformationData.body);

      ref.read(userDataProvider.notifier).setUserData(responseChangeData);

      // Navigator.pushNamed(context, AppRoutes().profilescreen);

      // You might want to store the user ID or navigate to a new screen
    } else {
      // Handle authentication error
      print('Changing the userProfile failed: ${userInformationData.body}');
    }
  }
}
