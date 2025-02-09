import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeedbackOptionForAirport extends StatelessWidget {
  final int numForIdentifyOfParent;
  final String iconUrl;
  final int label;
  final int selectedNumberOfSubcategory;

  const FeedbackOptionForAirport({
    super.key,
    required this.numForIdentifyOfParent,
    required this.iconUrl,
    required this.label,
    required this.selectedNumberOfSubcategory,
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
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Material(
          elevation: selectedNumberOfSubcategory > 0 ? 4 : 2,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              gradient: selectedNumberOfSubcategory > 0
                  ? LinearGradient(
                      colors: [AppStyles.blackColor, Color(0xFF2C2C2C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: selectedNumberOfSubcategory > 0 ? null : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selectedNumberOfSubcategory > 0
                    ? Colors.transparent
                    : Colors.grey.shade300,
                width: 1.5,
              ),
              boxShadow: selectedNumberOfSubcategory > 0
                  ? [
                      BoxShadow(
                        color: AppStyles.blackColor.withOpacity(0.51),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: selectedNumberOfSubcategory > 0
                            ? Colors.white
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          iconUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        labelName,
                        style: AppStyles.textStyle_14_600.copyWith(
                          color: selectedNumberOfSubcategory > 0
                              ? Colors.white
                              : Colors.black87,
                          fontSize: 15,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (selectedNumberOfSubcategory > 0)
                  Positioned(
                    top: -10,
                    right: -10,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.38),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "$selectedNumberOfSubcategory",
                          style: AppStyles.textStyle_12_600.copyWith(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
