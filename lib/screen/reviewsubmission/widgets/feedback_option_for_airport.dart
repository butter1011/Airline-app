import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FeedbackOptionForAirport extends StatelessWidget {
  final int numForIdentifyOfParent;
  final String iconUrl;
  final int label;
  final int selectedNumberOfSubcategoryForLike;

  const FeedbackOptionForAirport(
      {super.key,
      required this.numForIdentifyOfParent,
      required this.iconUrl,
      required this.label,
      required this.selectedNumberOfSubcategoryForLike,
});

  @override
  Widget build(BuildContext context) {
    List<dynamic> mainCategoryNames = [];

    for (var category in mainCategoryAndSubcategoryForAirport) {
      mainCategoryNames.add(category['mainCategory'] as String);
    }
    final labelName = mainCategoryNames[label];
    return GestureDetector(
      onTap: () {
        if (numForIdentifyOfParent == 1) {
          Navigator.pushNamed(context, AppRoutes.detailfirstscreenforairport,
              arguments: {'singleAspect': label});
        } else if (numForIdentifyOfParent == 2) {
       
          Navigator.pushNamed(context, AppRoutes.detailsecondscreenforairport,
              arguments: {'singleAspect': label});
        }
   
      }, // Change color on tap
      child: Stack(
        children: [
          Container(
            height: 126,
            width: MediaQuery.of(context).size.width * 0.41,
            decoration: AppStyles.cardDecoration.copyWith(
              color: selectedNumberOfSubcategoryForLike > 0
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
                    color: selectedNumberOfSubcategoryForLike > 0
                        ? Colors.white
                        : AppStyles.mainColor,
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
          if (selectedNumberOfSubcategoryForLike > 0)
            Positioned(
                top: 12,
                right: 16,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: AppStyles.badgeDecoration,
                  child: Center(
                    child: Text(
                      "$selectedNumberOfSubcategoryForLike",
                      style: AppStyles.textStyle_12_600,
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}
