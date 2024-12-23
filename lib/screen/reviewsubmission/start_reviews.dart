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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: screenSize.height*0.08,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('Reviews'),
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
            width: screenSize.width * 1.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/run_airport.png"),
                    fit: BoxFit.cover)),
            height: screenSize.height * 0.54, // Add a specific height
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
              Image.asset("assets/images/baggage.png"),
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
              Image.asset("assets/images/flight.png"),
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
          Padding(
              padding: const EdgeInsets.only(right: 32, left: 32, top: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to your feedback Quest",
                    style: AppStyles.textStyle_24_600,
                  ),
                  Text(
                    "Like, dislike,  its as simple as that",
                    style: AppStyles.textStyle_15_400,
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
                    text: AppLocalizations.of(context).translate('Start'),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.reviewsubmissionscreen);
                    },
                    color: AppStyles.mainColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
