import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_navigation_buttons_widget.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_question_header.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option_for_airport.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionFirstScreenForAirline extends ConsumerWidget {
  const QuestionFirstScreenForAirline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionsForAirline = ref.watch(reviewFeedBackProviderForAirline);
    final selectionsForAirport = ref.watch(reviewFeedBackProviderForAirport);
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
          flexibleSpace: BuildQuestionHeader(
            backgroundImage: backgroundImage,
            title: "Lets go into more detail about this?",
            subTitle: "Your feedback helps make every journey better!",
            logoImage: logoImage,
            classes: selectedClassOfTravel,
            airlineName: airline,
            from: from,
            to: to,
            parent:1,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildFeedbackOptions(selectionsForAirline, selectionsForAirport),
              BuildNavigationButtonsWidget(
                onBackPressed: () {
                  Navigator.pushNamed(
                      context, AppRoutes.reviewsubmissionscreen);
                                      ref.read(aviationInfoProvider.notifier).resetState();
                  ref
                      .read(reviewFeedBackProviderForAirline.notifier)
                      .resetState();
                  ref
                      .read(reviewFeedBackProviderForAirport.notifier)
                      .resetState();
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
    selectionsForAirline, selectionsForAirport
  ) {
    final List<Map<String, dynamic>> feedbackOptionsForAirline = 
        mainCategoryAndSubcategoryForAirline;

           final List<Map<String, dynamic>> feedbackOptionsForAirport =
        mainCategoryAndSubcategoryForAirport;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select positive aspects',
              style: AppStyles.textStyle_18_600,
            ),
            SizedBox(height: 8),
            Divider(height: 1, color: Colors.grey.withOpacity(0.2)),            
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 1,
                        children: List.generate(
                          feedbackOptionsForAirline.length,
                          (index) => FeedbackOptionForAirline(
                            numForIdentifyOfParent: 1,
                            iconUrl: feedbackOptionsForAirline[index]['iconUrl'],
                            label: index,
                            selectedNumberOfSubcategoryForLike: selectionsForAirline[index]
                                    ['subCategory']
                                .values
                                .where((s) => s == true)
                                .length,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                         spacing: 1,
                        children: List.generate(
                          feedbackOptionsForAirport.length,
                          (index) => FeedbackOptionForAirport(
                            numForIdentifyOfParent: 1,
                            iconUrl: feedbackOptionsForAirport[index]['iconUrl'],
                            label: index,
                            selectedNumberOfSubcategory: selectionsForAirport[index]
                                    ['subCategory']
                                .values
                                .where((s) => s == true)
                                .length,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
