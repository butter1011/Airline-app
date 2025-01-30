import 'package:airline_app/screen/app_widgets/appbar_widget.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_score_icon.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:airline_app/provider/score_provider.dart';

class CompleteReviews extends ConsumerWidget {
  const CompleteReviews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final scores = ref.watch(scoreProvider);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: Scaffold(
        appBar: AppbarWidget(title: "Feedback Quest Complete"),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.1),
                child: Container(
                  width: screenSize.width * 0.43,
                  height: screenSize.width * 0.43,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/attendant.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/step_progress_indicator_black.png",
                  width: screenSize.width * 0.8,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ]),
        bottomNavigationBar: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 27, bottom: 16, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 4,
                            width: 32,
                            decoration: BoxDecoration(
                              color: Color(0xff97A09C),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Center(
                          child: Text(
                              "Airline Score is ${(scores['airlineScore'] ?? 0).toStringAsFixed(1)}",
                              style: AppStyles.textStyle_32_600),
                        ),
                        Center(
                          child: Text(
                              "Airport Score is ${(scores['airportScore'] ?? 0).toStringAsFixed(1)}",
                              style: AppStyles.textStyle_32_600),
                        ),
                        const SizedBox(height: 21),
                        Text(
                          "Your feedback helps make every journey better!",
                          style: AppStyles.textStyle_14_400,
                        ),
                        const SizedBox(height: 18),
                        const Row(
                          children: [
                            ReviewScoreIcon(
                                iconUrl: 'assets/icons/review_cup.png'),
                            SizedBox(width: 16),
                            ReviewScoreIcon(
                                iconUrl:
                                    'assets/icons/review_notification.png'),
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
                        text: "Home",
                        onPressed: () => Navigator.pushNamed(
                            context, AppRoutes.leaderboardscreen),
                        color: Colors.white),
                  )
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.reviewsubmissionscreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
