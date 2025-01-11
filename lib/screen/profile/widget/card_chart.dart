import 'dart:convert';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/screen/profile/widget/review_button.dart';
import 'package:airline_app/provider/selected_button_provider.dart';

class CardChart extends ConsumerStatefulWidget {
  @override
  ConsumerState<CardChart> createState() => _CardChartState();
}

class _CardChartState extends ConsumerState<CardChart> {
  final List<Map<String, String>> buttons = [
    {'iconUrl': 'assets/icons/reviewmessage.png', 'label': 'Top Reviewer'},
    {
      'iconUrl': 'assets/icons/review_icon_comfort.png',
      'label': 'Excellent Reviewer'
    },
    {
      'iconUrl': 'assets/icons/review_icon_cleanliness.png',
      'label': 'Good Reviewer'
    },
    {
      'iconUrl': 'assets/icons/review_icon_onboard.png',
      'label': 'Fair Reviewer'
    },
    {
      'iconUrl': 'assets/icons/review_icon_food.png',
      'label': 'Needs Improvement'
    },
    {
      'iconUrl': 'assets/icons/review_icon_entertainment.png',
      'label': 'No Review'
    },
  ];

  void _badgeFunction(int index) async {
    final userData = ref.watch(userDataProvider);

    final userInformationData = await http.post(
      Uri.parse('$apiUrl/api/v1/badgeEditUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'selectedbadges': buttons[index]['label'],
        '_id': userData?['userData']['_id'],
      }),
    );

    if (userInformationData.statusCode == 200) {
      final responseChangeData = jsonDecode(userInformationData.body);
      ref.read(userDataProvider.notifier).setUserData(responseChangeData);
    } else {
      print('Changing the userProfile failed: ${userInformationData.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int points = ref.watch(userDataProvider)?["userData"]["points"];
    final selectedButtonIndex = ref.watch(selectedButtonProvider);

    List<Map<String, String>> sortedButtons = List.from(buttons);
    List<Map<String, String>> activeButtons = [];
    List<Map<String, String>> lockedButtons = [];

    for (var button in sortedButtons) {
      final isLocked = !((points >= 500 &&
              points < 3000 &&
              (button['label'] == 'Needs Improvement' ||
                  button['label'] == 'No Review')) ||
          (points >= 3000 &&
              points < 5000 &&
              (button['label'] == 'Fair Reviewer' ||
                  button['label'] == 'Needs Improvement' ||
                  button['label'] == 'No Review')) ||
          (points >= 5000 &&
              points < 7000 &&
              (button['label'] == 'Good Reviewer' ||
                  button['label'] == 'Fair Reviewer' ||
                  button['label'] == 'Needs Improvement' ||
                  button['label'] == 'No Review')) ||
          (points >= 7000 &&
              points < 10000 &&
              (button['label'] == 'Excellent Reviewer' ||
                  button['label'] == 'Good Reviewer' ||
                  button['label'] == 'Fair Reviewer' ||
                  button['label'] == 'Needs Improvement' ||
                  button['label'] == 'No Review')) ||
          (points >= 10000));

      if (isLocked) {
        lockedButtons.add(button);
      } else {
        activeButtons.add(button);
      }
    }

    sortedButtons = [...activeButtons, ...lockedButtons];

    if (selectedButtonIndex != null) {
      int actualIndex = sortedButtons
          .indexWhere((button) => buttons[selectedButtonIndex] == button);
      if (actualIndex != -1) {
        final selectedButton = sortedButtons.removeAt(actualIndex);
        sortedButtons.insert(0, selectedButton);
      }
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
                final button = sortedButtons[index];
                final buttonIndex = buttons.indexOf(button);
                final isLocked = lockedButtons.contains(button);

                return ReviewButton(
                  iconUrl: button['iconUrl']!,
                  label: AppLocalizations.of(context)
                      .translate('${button['label']}')
                      .toString(),
                  isSelected: selectedButtonIndex == buttonIndex,
                  isLocked: isLocked,
                  onTap: () {
                    if (!isLocked) {
                      ref
                          .read(selectedButtonProvider.notifier)
                          .selectButton(buttonIndex);
                      _badgeFunction(buttonIndex);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
