import 'package:airline_app/screen/profile/utils/calender_sync_json.dart';
import 'package:airline_app/screen/profile/widget/basic_black_button.dart';
import 'package:airline_app/screen/profile/widget/basic_button.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:airline_app/utils/app_localizations.dart';

class CalenderSyncScreen extends StatefulWidget {
  const CalenderSyncScreen({super.key});

  @override
  State<CalenderSyncScreen> createState() => _CalenderSyncScreenState();
}

class _CalenderSyncScreenState extends State<CalenderSyncScreen> {
  List<bool> isSelected = [false, false, false, false];

  void toggleSelection(int index) {
    setState(() {
      isSelected[index] = !isSelected[index]; // Toggle the selected state
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(AppLocalizations.of(context).translate('Calendar Sync'),
          style: AppStyles.textStyle_16_600.copyWith(color: Colors.black)),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(color: Colors.black, height: 4.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text('Type', style: AppStyles.textStyle_16_600),
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
