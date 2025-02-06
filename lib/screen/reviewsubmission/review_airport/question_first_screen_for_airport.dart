import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/build_question_header_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_navigation_buttons_widget.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option_for_airport.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionFirstScreenForAirport extends ConsumerWidget {
  const QuestionFirstScreenForAirport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(reviewFeedBackProviderForAirport);
    final (numberOfFirstSelectedAspects, numberOfSecondSelectedAspects) = ref
        .watch(reviewFeedBackProviderForAirport.notifier)
        .numberOfSelectedAspects();

    final airlineData = ref.watch(aviationInfoProvider);

    final airportname = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlineData.from);
    final logoImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportLogoImage(airlineData.from);
    final backgroundImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportBackgroundImage(airlineData.from);

    final selectedClassOfTravel = airlineData.selectedClassOfTravel;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, AppRoutes.airportinput);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.3,
          flexibleSpace: BuildQuestionHeaderForAirport(
            airportName: airportname,
            title: "Lets go into more detail about this?",
            subTitle: "Your feedback helps make every journey better!",
            logoImage: logoImage,
            backgroundImage: backgroundImage,
            selecetedOfCalssLevel: selectedClassOfTravel,
            parent: 1,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildFeedbackOptions(selections, numberOfFirstSelectedAspects,
                  numberOfSecondSelectedAspects),
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
                    context, AppRoutes.questionsecondscreenforairport);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackOptions(selections, int numberOfFirstSelectedAspects,
      int numberOfSecondSelectedAspects) {
    final List<Map<String, dynamic>> feedbackOptions =
        mainCategoryAndSubcategoryForAirport;

    List<dynamic> mainCategoryNames = [];

    for (var category in mainCategoryAndSubcategoryForAirport) {
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
              style: AppStyles.textStyle_18_600,
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
                return FeedbackOptionForAirport(
                  numForIdentifyOfParent: 1,
                  iconUrl: feedbackOptions[index]['iconUrl'],
                  label: index,
                  selectedNumberOfSubcategory: selections[index]
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
