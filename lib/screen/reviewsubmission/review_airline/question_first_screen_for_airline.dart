import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionFirstScreenForAirline extends ConsumerWidget {
  const QuestionFirstScreenForAirline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(reviewFeedBackProviderForAirline);
    final int numberOfSelectedAspects = ref
        .watch(reviewFeedBackProviderForAirline.notifier)
        .numberOfSelectedAspects();
    final airlinData = ref.watch(aviationInfoProvider);
    final from = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlinData.from);

    final to = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlinData.to);

    final airline = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineName(airlinData.airline);

    final logoImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineLogoImage(airlinData.airline);

    final selectedClassOfTravel = airlinData.selectedClassOfTravel;
    final dateRanged = airlinData.dateRange;
    final backgroundImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineBackgroundImage(airlinData.airline);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.flightinput);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.3,
          flexibleSpace: BuildQuestionHeader(
            backgorundImage: backgroundImage,
            subTitle: "Tell us what you liked about your journey.",
            logoImage: logoImage,
            classes: selectedClassOfTravel,
            airlineName: airline,
            from: from,
            to: to,
            dateRange: dateRanged,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildFeedbackOptions(selections, numberOfSelectedAspects),
              _buildNavigationButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackOptions(selections, int numberOfSelectedAspects) {
    final List<Map<String, dynamic>> feedbackOptions =
        mainCategoryAndSubcategoryForAirline;

    List<String> mainCategoryNames = [];

    for (var category in mainCategoryAndSubcategoryForAirline) {
      mainCategoryNames.add(category['mainCategory'] as String);
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select up to 4 positive aspects',
              style: AppStyles.textStyle_14_600,
            ),
            SizedBox(height: 16),
            Expanded(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: feedbackOptions.length, // Use the length of the list
              itemBuilder: (context, index) {
                return FeedbackOptionForAirline(
                  numForIdentifyOfParent: 1,
                  iconUrl: feedbackOptions[index]['iconUrl'],
                  label: index,
                  numberOfSelectedAspects: numberOfSelectedAspects,
                  selectedNumberOfSubcategoryForLike: selections[index]
                          ['subCategory']
                      .values
                      .where((s) => s == true)
                      .length,
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(context) {
    return Column(
      children: [
        Container(
          height: 2,
          color: Colors.black,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: NavPageButton(
                    text: 'Go back',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icons.arrow_back),
              ),
              SizedBox(width: 16),
              Expanded(
                child: NavPageButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.questionsecondscreenforairline);
                    },
                    icon: Icons.arrow_forward),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BuildQuestionHeader extends StatelessWidget {
  const BuildQuestionHeader(
      {super.key,
      required this.subTitle,
      required this.logoImage,
      required this.airlineName,
      required this.dateRange,
      required this.classes,
      required this.from,
      required this.backgorundImage,
      required this.to});
  final String subTitle;
  final String logoImage;
  final String backgorundImage;
  final String airlineName;
  final List dateRange;
  final String classes;
  final String from;
  final String to;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            backgorundImage,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color:
              Color(0xff181818).withOpacity(0.75), // Black overlay with opacity
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(logoImage),
                          fit: BoxFit.cover,
                        ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Column(
                    children: [
                      Text(
                        airlineName,
                        style: AppStyles.oswaldTextStyle,
                      ),
                      Text(
                        'AIRLINES',
                        style: AppStyles.oswaldTextStyle,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                subTitle,
                style: AppStyles.textStyle_18_600
                    .copyWith(color: Color(0xffF9F9F9)),
              ),
              Text(
                'Your feedback helps us improve!',
                style: AppStyles.textStyle_15_600
                    .copyWith(color: Color(0xffC1C7C4)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '$airlineName, ${dateRange[0]}, $classes',
                style: AppStyles.textStyle_15_600.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '$from > $to',
                style: AppStyles.textStyle_15_600.copyWith(color: Colors.white),
              ),
              Spacer(), // This will push the following container to the bottom
              Container(
                height: 24,
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24))),

                // Center text inside the container
              ),
            ],
          ),
        ),
      ],
    );
  }
}
