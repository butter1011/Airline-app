import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FeedbackOption extends StatelessWidget {
  final String iconUrl;
  final int label;

  final int selectedNumber;
  final int numberOfSelectedAspects;

  FeedbackOption(
      {super.key,
      required this.iconUrl,
      required this.label,
      required this.selectedNumber,
      required this.numberOfSelectedAspects});
  final List<String> labelKeys = aspectsForElevation.keys.toList();

  @override
  Widget build(BuildContext context) {
    final labelName = labelKeys[label];
    return GestureDetector(
      onTap: () {
        if (numberOfSelectedAspects > 3) {
          _showAlertDialog(context);
        } else {
          Navigator.pushNamed(context, AppRoutes.detailfirstscreen,
              arguments: {'singleAspect': label});
        }
      }, // Change color on tap
      child: Stack(
        children: [
          Container(
            height: 126,
            width: MediaQuery.of(context).size.width * 0.41,
            decoration: AppStyles.cardDecoration.copyWith(
              color: selectedNumber > 0
                  ? AppStyles.mainColor
                  : Colors.white, // Change color based on click state
            ),
            padding: EdgeInsets.only(
                bottom: 10, top: 16), // Add padding for better spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: AppStyles.cardDecoration.copyWith(
                    color:
                        selectedNumber > 0 ? Colors.white : AppStyles.mainColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(iconUrl, height: 40),
                ),
                SizedBox(height: 6),
                Text(
                  labelName,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle_14_600, // Optional styling
                ),
              ],
            ),
          ),
          if (selectedNumber > 0)
            Positioned(
                top: 12,
                right: 16,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: AppStyles.badgeDecoration,
                  child: Center(
                    child: Text(
                      "$selectedNumber",
                      style: AppStyles.textStyle_12_600,
                    ),
                  ),
                ))
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Limit Exceeded"),
          content: Text("You can select up to 4 positive aspects."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
