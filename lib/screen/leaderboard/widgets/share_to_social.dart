import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BottomSheetHelper {
  static Future<void> showScoreBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(color: Color(0xFF97A09C)),
                ),
                SizedBox(height: 8),
                Expanded(
                    // Use Expanded to allow scrolling
                    child: SingleChildScrollView(
                  // Enable scrolling
                  child: Wrap(spacing: 16, runSpacing: 3, children: [
                    SingleFriendCard(
                      avatar: 'assets/icons/icon_link.png',
                      name: 'Copy link',
                    ),
                    ...List.generate(socialList.length, (index) {
                      return SingleFriendCard(
                        avatar: socialList[index]['Avatar'].isNotEmpty
                            ? socialList[index]['Avatar']
                            : 'assets/icons/google.png',
                        name: socialList[index]['Name'],
                      );
                    }),
                    SingleFriendCard(
                      avatar: 'assets/icons/dot menu.png',
                      name: 'More',
                    ),
                  ]),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class SingleFriendCard extends StatelessWidget {
  const SingleFriendCard({super.key, required this.avatar, required this.name});
  final String avatar;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: AppStyles.circleDecoration.copyWith(
                image: DecorationImage(
                    image: AssetImage(
              avatar,
            ))),
          ),
          SizedBox(height: 12),
          Text(
            name, // Assuming there's a name field
            style: AppStyles.textStyle_13_600,
          ),
        ],
      ),
    );
  }
}
