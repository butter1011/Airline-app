import 'package:airline_app/screen/app_widgets/appbar_widget.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class StartReviews extends StatelessWidget {
  const StartReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppbarWidget(
        title: "Reviews",
        onBackPressed: () {
          Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        },
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.12),
          child: Container(
            width: screenSize.width * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/plane.png"),
                    fit: BoxFit.cover)),
            height: screenSize.width * 0.3, // Add a specific height
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Image.asset("assets/images/step_progress_indicator_default.png"),
     

        Padding(
            padding: const EdgeInsets.only(right: 32, left: 32, top: 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to your feedback Quest",
                  style: AppStyles.textStyle_24_600,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Verify your flight. Share what you like and dislike about your journey—it's as simple as that. Let us handle the rest.",
                  style: AppStyles.textStyle_15_400
                      .copyWith(color: Color(0xFFff676767)),
                )
              ],
            )),
      ]),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 12),
                NavButton(
                  text: AppLocalizations.of(context).translate('Next'),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, AppRoutes.reviewsubmissionscreen);
                  },
                  color: AppStyles.backgroundColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
