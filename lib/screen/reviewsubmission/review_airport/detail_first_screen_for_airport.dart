import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/build_question_header_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/build_navigation_buttons_widget.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/subcategory_button_widget.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailFirstScreenForAirport extends ConsumerWidget {
  const DetailFirstScreenForAirport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(reviewFeedBackProviderForAirport);
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final int singleIndex = args?['singleAspect'] ?? '';
    List<dynamic> mainCategoryNames = [];
    for (var category in mainCategoryAndSubcategoryForAirport) {
      mainCategoryNames.add(category['mainCategory'] as String);
    }

    // Ensure subCategoryList is not null
    final Map<String, dynamic> subCategoryList =
        mainCategoryAndSubcategoryForAirport[singleIndex]['subCategory'];

    final airlinData = ref.watch(aviationInfoProvider);
    print("dfasdfadsfads======${airlinData.from}");

    final airportname = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlinData.from);
    final logoImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportLogoImage(airlinData.from);
    final backgroundImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportBackgroundImage(airlinData.from);

    final selectedClassOfTravel = airlinData.selectedClassOfTravel;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: BuildQuestionHeaderForAirport(
              airportName: airportname,
              title: "Tell us about your airport experience",
              subTitle: "What did you like about your experience?",
              logoImage: logoImage,
              backgroundImage: backgroundImage,
              selecetedOfCalssLevel: selectedClassOfTravel,
              parent: 1,
            )),
        body: SafeArea(
            child: Column(
          children: [
            _buildFeedbackOptions(
                ref, singleIndex, subCategoryList, selections),
            BuildNavigationButtonsWidget(
              onBackPressed: () {
                Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
                ref.read(aviationInfoProvider.notifier).resetState();
                ref
                    .read(reviewFeedBackProviderForAirline.notifier)
                    .resetState();
                ref
                    .read(reviewFeedBackProviderForAirport.notifier)
                    .resetState();
              },
              onNextPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )));
  }

  Widget _buildFeedbackOptions(
      WidgetRef ref, int singleIndex, subCategoryList, selections) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${selections[singleIndex]['mainCategory']}",
              style: AppStyles.textStyle_14_600,
            ),
            SizedBox(height: 16),
            Expanded(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: subCategoryList.length, // Use the length of the list
              itemBuilder: (context, index) {
                Map<String, dynamic> items =
                    selections[singleIndex]['subCategory'];
                String imagePath = selections[singleIndex]['iconUrl'];
                List itemkeys = items.keys.toList();
                List itemValues = items.values.toList();
                String key = itemkeys[index];
                dynamic value = itemValues[index];
                return Opacity(
                  opacity: value == false ? 0.5 : 1,
                  child: SubcategoryButtonWidget(
                    labelName: itemkeys[index],
                    isSelected: value == true ? true : false,
                    onTap: () {
                      value == false
                          ? print("Value is false, no action performed.")
                          : ref
                              .read(reviewFeedBackProviderForAirport.notifier)
                              .selectLike(singleIndex, key);
                    },
                    imagePath: imagePath,
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
