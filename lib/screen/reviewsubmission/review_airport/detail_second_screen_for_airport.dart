import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/provider/review_feedback_provider_for_airport.dart';
import 'package:airline_app/screen/reviewsubmission/review_airport/question_first_screen_for_airport.dart';

import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailSecondScreenForAirport extends ConsumerWidget {
  const DetailSecondScreenForAirport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(reviewFeedBackProviderForAirport);
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final int singleIndex = args?['singleAspect'] ?? '';
    List<dynamic> mainCategoryNames = [];
    for (var category in mainCategoryAndSubcategoryForAirport) {
      mainCategoryNames.add(category['mainCategory'] as String);
    }
    String singleAspect = mainCategoryNames[singleIndex];

    // Ensure subCategoryList is not null
    final Map<String, dynamic> subCategoryList =
        mainCategoryAndSubcategoryForAirport[singleIndex]['subCategory'];

    final selectedNumberOfSubcategoryForDislike = ref
        .watch(reviewFeedBackProviderForAirport.notifier)
        .selectedNumberOfSubcategoryForDislike(singleIndex);

    final airlinData = ref.watch(aviationInfoProvider);

    final airportname = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlinData.airport);
    final logoImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportLogoImage(airlinData.airport);
    final backgroundImage = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportBackgroundImage(airlinData.airport);

    final selectedClassOfTravel = airlinData.selectedClassOfTravel;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.3,
          flexibleSpace: BuildQuestionHeader(
            airportName: airportname,
            subTitle: "What could be improved?",
            logoImage: logoImage,
            backgroundImage: backgroundImage,
            selecetedOfCalssLevel: selectedClassOfTravel,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context),
              SizedBox(height: 10),
              _buildHeaderContainer(
                  context, singleAspect, selectedNumberOfSubcategoryForDislike
                  // selections.where((s) => s).length,
                  ),
              SizedBox(height: 16),
              _buildFeedbackOptions(
                  ref, singleIndex, subCategoryList, selections),
              SizedBox(height: 12),
              _buildOptionalText(),
              SizedBox(height: 6),
              _buildTextField(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderContainer(BuildContext context, String singleAspect,
      int selectedNumberOfSubcategoryForDislike) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: AppStyles.cardDecoration.copyWith(
        borderRadius: BorderRadius.circular(24),
        color: AppStyles.mainColor,
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: AppStyles.iconDecoration,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                "assets/icons/review_icon_boarding.png",
                width: 18,
                height: 18,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(singleAspect, style: AppStyles.textStyle_14_600),
          ),
          Align(
            alignment: Alignment(0, -0.5), // Align to the top

            child: Container(
              height: 20,
              width: 20,
              decoration: AppStyles.badgeDecoration,
              child: Center(
                child: Text(
                  selectedNumberOfSubcategoryForDislike.toString(),
                  style: AppStyles.textStyle_13_600,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackOptions(
      WidgetRef ref, int singleIndex, subCategoryList, selections) {
    // List isSelectedList = ref.watch(reviewFeedBackProviderForAirline);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(subCategoryList.length, (index) {
        Map<String, dynamic> items = selections[singleIndex]['subCategory'];
        List itemkeys = items.keys.toList();
        List itemValues = items.values.toList();
        String key = itemkeys[index];
        dynamic value = itemValues[index];

        return GestureDetector(
          onTap: () {
            value == true
                ? print("Value is true, no action performed.")
                : ref
                    .read(reviewFeedBackProviderForAirport.notifier)
                    .selectDislike(singleIndex, key);
          },
          child: Opacity(
            opacity: value == true ? 0.5 : 1,
            child: IntrinsicWidth(
              child: Container(
                height: 40,
                decoration: AppStyles.cardDecoration.copyWith(
                  borderRadius: BorderRadius.circular(16),
                  color:
                      items[key] == false ? AppStyles.mainColor : Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      itemkeys[index].toString(),
                      style: AppStyles.textStyle_14_600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
        SizedBox(width: 2),
        Text('Go Back', style: AppStyles.textStyle_16_600),
      ],
    );
  }

  Widget _buildOptionalText() {
    return Row(
      children: [
        Text("Others ", style: AppStyles.textStyle_14_600),
        Text(
          " (Optional)",
          style: AppStyles.textStyle_14_600.copyWith(color: Color(0xff97A09C)),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: AppStyles.cardDecoration.copyWith(
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        maxLines: null, // Allows unlimited lines
        decoration: InputDecoration(
          hintText: "What did you also like?",
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
