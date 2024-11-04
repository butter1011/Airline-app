import 'package:airline_app/screen/profile/utils/calender_sync_json.dart';
import 'package:airline_app/screen/profile/widget/basic_black_button.dart';
import 'package:airline_app/screen/profile/widget/basic_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<bool> isSelected = [false, false, false, false];

  void toggleSelection(int index) {
    setState(() {
      isSelected[index] = !isSelected[index]; // Toggle the selected state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profilescreen);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
        title: Text(
          "Notifications",
          textAlign: TextAlign.center,
          style: AppStyles.textStyle_16_600,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Divider(thickness: 4, color: Colors.black),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Type',
              style: AppStyles.textStyle_14_400,
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(isSelected.length, (index) {
                return GestureDetector(
                  onTap: () =>
                      toggleSelection(index), // Toggle selection on tap
                  child: BasicButton(
                    mywidth: index == 0 ? 49 : (index == 2 ? 94 : 161),
                    myheight: 40,
                    myColor: isSelected[index]
                        ? AppStyles.mainColor
                        : Colors.white, // Change color based on selection
                    btntext: index == 0
                        ? "All"
                        : "Category goes here", // Update button text accordingly
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 20),
          Divider(thickness: 2, color: Colors.black),
          // Use ListView.builder for better performance
          ListView.builder(
            shrinkWrap: true, // Allows it to be embedded in a scrollable widget
            physics:
                NeverScrollableScrollPhysics(), // Disable scrolling for this ListView
            itemCount: calenderSync.length, // Assuming calenderSync is a list
            itemBuilder: (context, index) {
              final calenter = calenderSync[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Container(
                  width: double.infinity, // Use full width available
                  decoration: AppStyles.notificationDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              calenter['topic'],
                              style: AppStyles.textStyle_16_600,
                            ),
                            const Icon(Icons.arrow_forward_sharp)
                          ],
                        ),
                        SizedBox(
                            height:
                                8), // Add some space between topic and contents
                        Text(
                          calenter['contents'],
                          style: AppStyles.textStyle_14_600.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        SizedBox(height: 18),
                        BasicBlackButton(
                          mywidth: 126,
                          myheight: 24,
                          myColor: Colors.black,
                          btntext: 'Recommended',
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
