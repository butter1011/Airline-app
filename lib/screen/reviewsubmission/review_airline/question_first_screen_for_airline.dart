import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/build_question_header_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_navigation_buttons_widget.dart';
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

    final (numberOfFirstSelectedAspects, numberOfSecondSelectedAspects) = ref
        .watch(reviewFeedBackProviderForAirline.notifier)
        .numberOfSelectedAspects();
    final airlineData = ref.watch(aviationInfoProvider);
    final from = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlineData.from);

    final to = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlineData.to);

    final airline = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineName(airlineData.airline);

    final logoImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineLogoImage(airlineData.airline);

    final selectedClassOfTravel = airlineData.selectedClassOfTravel;
    final backgroundImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineBackgroundImage(airlineData.airline);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.flightinput);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.3,
          automaticallyImplyLeading: false,
          flexibleSpace: BuildQuestionHeaderForAirline(
            backgroundImage: backgroundImage,
            title: "Lets go into more detail about this?",
            subTitle: "Your feedback helps make every journey better!",
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
              _buildFeedbackOptions(selections),
              BuildNavigationButtonsWidget(
                onBackPressed: () {
                  Navigator.pop(context);
                },
                onNextPressed: () {
                  Navigator.pushNamed(
                      context, AppRoutes.questionsecondscreenforairline);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackOptions(
    selections,
  ) {
    final List<Map<String, dynamic>> feedbackOptions =
        mainCategoryAndSubcategoryForAirline;

    List<dynamic> mainCategoryNames = [];

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
              'Select positive aspects',
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
}
