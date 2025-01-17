import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/review_airline/build_question_header_for_airline.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/subcategory_button_widget.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailFirstScreenForAirline extends ConsumerWidget {
  const DetailFirstScreenForAirline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(reviewFeedBackProviderForAirline);
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final int singleIndex = args?['singleAspect'] ?? '';
    List<dynamic> mainCategoryNames = [];
    for (var category in mainCategoryAndSubcategoryForAirline) {
      mainCategoryNames.add(category['mainCategory'] as String);
    }
    String singleAspect = mainCategoryNames[singleIndex];

    // Ensure subCategoryList is not null
    final Map<String, dynamic> subCategoryList =
        mainCategoryAndSubcategoryForAirline[singleIndex]['subCategory'];

    final selectedItemNumter = ref
        .watch(reviewFeedBackProviderForAirline.notifier)
        .selectedNumberOfSubcategoryForLike(singleIndex);

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
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading:false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.3,
          flexibleSpace: BuildQuestionHeaderForAirline(
            backgorundImage: backgroundImage,
            subTitle: "Tell us what you liked about your journey.",
            logoImage: logoImage,
            classes: selectedClassOfTravel,
            airlineName: airline,
            from: from,
            to: to,
          ), // Assuming this method exists
        ),
        body: SafeArea(
            child: Column(
          children: [
            _buildFeedbackOptions(
                ref, singleIndex, subCategoryList, selections),
            _buildNavigationButtons(context),
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
                childAspectRatio: 1.3,
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
                              .read(reviewFeedBackProviderForAirline.notifier)
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

  Widget _buildNavigationButtons(context) {
    return Column(
      children: [
        Container(
          height: 2,
          color: Colors.black,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: NavPageButton(
              text: 'Go back',
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icons.arrow_back),
        ),
      ],
    );
  }
}
