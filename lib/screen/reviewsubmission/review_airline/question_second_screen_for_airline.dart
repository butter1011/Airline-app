import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/question_first_screen_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionSecondScreenForAirline extends ConsumerWidget {
  const QuestionSecondScreenForAirline({super.key});

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
        Navigator.pushNamed(context, AppRoutes.questionfirstscreenforairline);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.3,
          flexibleSpace: BuildQuestionHeader(
            backgorundImage: backgroundImage,
            subTitle: "What could be improved?",
            logoImage: logoImage,
            classes: selectedClassOfTravel,
            airlineName: airline,
            from: from,
            to: to,
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
              'Select up to 4 negative aspects',
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
                  numForIdentifyOfParent: 2,
                  iconUrl: feedbackOptions[index]['iconUrl'],
                  label: index,
                  numberOfSelectedAspects: numberOfSelectedAspects,
                  selectedNumberOfSubcategoryForLike: selections[index]
                          ['subCategory']
                      .values
                      .where((s) => s == false)
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
                          context, AppRoutes.questionthirdscreenforairline);
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
