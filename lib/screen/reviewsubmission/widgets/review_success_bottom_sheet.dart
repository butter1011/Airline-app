import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_score_icon.dart';

Future<void> showReviewSuccessBottomSheet(
    BuildContext context, VoidCallback onSuccess, String reviewButtonText) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 350,
              width: 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/success.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              height: MediaQuery.of(context).size.height * 0.37,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 27, bottom: 16, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text("Your Score is 9",
                              style: AppStyles.textStyle_32_600),
                        ),
                        const SizedBox(height: 21),
                        Text(
                          "You've earned 100 points",
                          style: AppStyles.textStyle_24_600
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Your feedback helps make every journey better!",
                          style: AppStyles.textStyle_14_400,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: const [
                            ReviewScoreIcon(
                                iconUrl: 'assets/icons/review_cup.png'),
                            SizedBox(width: 16),
                            ReviewScoreIcon(
                                iconUrl: 'assets/icons/review_notification.png'),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(thickness: 2, color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: NavButton(
                        text: reviewButtonText,
                        onPressed: () => Navigator.pushNamed(
                            context, AppRoutes.reviewsubmissionscreen),
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
