import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/build_question_header_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_navigation_buttons_widget.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_question_header.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option_for_airport.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionSecondScreenForAirline extends ConsumerWidget {
  const QuestionSecondScreenForAirline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionsForAirline = ref.watch(reviewFeedBackProviderForAirline);
    final selectionsFirAirport = ref.watch(reviewFeedBackProviderForAirport);
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
            backgroundImage: backgroundImage,
            title: "Lets go into more detail about this?",
            subTitle: "Your feedback helps make every journey better!",
            logoImage: logoImage,
            classes: selectedClassOfTravel,
            airlineName: airline,
            from: from,
            to: to,
            parent: 2,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildFeedbackOptions(selectionsForAirline, selectionsFirAirport),
              BuildNavigationButtonsWidget(onBackPressed: () {
                Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
                ref.read(aviationInfoProvider.notifier).resetState();
                ref
                    .read(reviewFeedBackProviderForAirline.notifier)
                    .resetState();
                ref
                    .read(reviewFeedBackProviderForAirport.notifier)
                    .resetState();
              }, onNextPressed: () {
                Navigator.pushNamed(
                    context, AppRoutes.submitscreen);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackOptions(selectionsForAirline, selectionsForAirport) {
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
              'Select negative aspects',
              style: AppStyles.textStyle_18_600,
            ),
            SizedBox(height: 8),
            Divider(height: 1, color: Colors.grey.withAlpha(51)),   
            Expanded(
                child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: List.generate(
                        feedbackOptionsForAirline.length,
                        (index) => FeedbackOptionForAirline(
                          numForIdentifyOfParent: 2,
                          iconUrl: feedbackOptionsForAirline[index]['iconUrl'],
                          label: index,
                          selectedNumberOfSubcategoryForLike: selectionsForAirline[index]
                                  ['subCategory']
                              .values
                              .where((s) => s == false)
                              .length,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: List.generate(
                        feedbackOptionsForAirport.length,
                        (index) => FeedbackOptionForAirport(
                          numForIdentifyOfParent: 2,
                          iconUrl: feedbackOptionsForAirport[index]['iconUrl'],
                          label: index,
                          selectedNumberOfSubcategory: selectionsForAirport[index]
                                  ['subCategory']
                              .values
                              .where((s) => s == false)
                              .length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

