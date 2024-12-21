import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_score_icon.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompleteReviews extends ConsumerWidget {
  const CompleteReviews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    final points = userData?["userData"]["points"];
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenSize.height * 0.08,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('Feedback Quest Complete'),
            style: AppStyles.textStyle_16_600,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: Container(
              color: Colors.black,
              height: 4.0,
            ),
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: screenSize.width,
            height: screenSize.height * 0.42,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/takeoff.png"),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "1",
                style: AppStyles.textStyle_24_600.copyWith(
                    color: AppStyles.mainColor, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset("assets/images/baggage_black.png"),
              SizedBox(
                width: 20,
              ),
              Text(
                "2",
                style: AppStyles.textStyle_24_600.copyWith(
                    color: AppStyles.mainColor, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 20,
              ),
              Image.asset("assets/images/flight_black.png"),
              SizedBox(
                width: 20,
              ),
              Text(
                "3",
                style: AppStyles.textStyle_24_600.copyWith(
                    color: AppStyles.mainColor, fontWeight: FontWeight.w900),
              ),
            ]),
          ),
        ]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          height: screenSize.height * 0.37,
          child: Column(
            children: [
              Padding(
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
                      "You've earned $points points",
                      style: AppStyles.textStyle_24_600
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Your feedback helps make every journey better!",
                      style: AppStyles.textStyle_14_400,
                    ),
                    const SizedBox(height: 18),
                    const Row(
                      children: [
                        ReviewScoreIcon(iconUrl: 'assets/icons/review_cup.png'),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: NavButton(
                    text: "Review Airport",
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.reviewsubmissionscreen),
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
