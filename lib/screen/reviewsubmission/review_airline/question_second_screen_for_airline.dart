import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/screen/app_widgets/bottom_button_bar.dart';
import 'package:airline_app/screen/app_widgets/main_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_question_header_for_submit.dart';
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
    final selectionsForAirport = ref.watch(reviewFeedBackProviderForAirport);
    final boardingPassDetail = ref.watch(aviationInfoProvider);
    final String from = boardingPassDetail.departureData["name"]??"";
    final String airline = boardingPassDetail.airlineData["name"]??"";
    final logoImage = boardingPassDetail.airlineData["logoImage"]??"";


    final List<Map<String, dynamic>> feedbackOptionsForAirline =
        mainCategoryAndSubcategoryForAirline;
    final List<Map<String, dynamic>> feedbackOptionsForAirport =
        mainCategoryAndSubcategoryForAirport;

    return PopScope(
      canPop: false, // Prevents the default pop action
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: BuildQuestionHeaderForSubmit(
              title: "Lets go into more detail about this?",
              subTitle: "Your feedback helps make every journey better!",
              logoImage: logoImage,
              airlineName: airline,
              airportName: from,
              parent: 1,
            ),
          ),
          body: Column(children: [
            Padding(
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
                    ])),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical:10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: List.generate(
                            feedbackOptionsForAirline.length,
                            (index) => FeedbackOptionForAirline(
                              numForIdentifyOfParent: 2,
                              iconUrl: feedbackOptionsForAirline[index]
                                  ['iconUrl'],
                              label: index,
                              selectedNumberOfSubcategoryForLike:
                                  selectionsForAirline[index]['subCategory']
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
                              iconUrl: feedbackOptionsForAirport[index]
                                  ['iconUrl'],
                              label: index,
                              selectedNumberOfSubcategory:
                                  selectionsForAirport[index]['subCategory']
                                      .values
                                      .where((s) => s == false)
                                      .length,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            )),
          ]),
          bottomNavigationBar: BottomButtonBar(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: MainButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.reviewsubmissionscreen);
                        ref.read(aviationInfoProvider.notifier).resetState();
                        ref
                            .read(reviewFeedBackProviderForAirline.notifier)
                            .resetState();
                        ref
                            .read(reviewFeedBackProviderForAirport.notifier)
                            .resetState();
                      })),
              SizedBox(width: 10),
              Expanded(
                  child: MainButton(
                      text: "Next",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.submitscreen);
                      }))
            ],
          ))),
    );
  }
}
