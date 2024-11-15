import 'package:airline_app/provider/count_like_provider.dart';
import 'package:airline_app/screen/reviewsubmission/question_first_screen.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/feedback_option.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionSecondScreen extends ConsumerWidget {
  const QuestionSecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(countLikeProvider);
    final int numberOfSelectedAspects =
        ref.watch(countLikeProvider.notifier).numberOfSelectedAspects();
    print("❤$numberOfSelectedAspects");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
        flexibleSpace: BuildQuestionHeader(
          subTitle: "What could be improved?",
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
    );
  }

  Widget _buildFeedbackOptions(selections, int numberOfSelectedAspects) {
    final List<Map<String, dynamic>> feedbackOptions =
        mainCategoryAndSubcategory;

    List<String> mainCategoryNames = [];

    for (var category in mainCategoryAndSubcategory) {
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
                return FeedbackOption(
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
                          context, AppRoutes.questionthirdscreen);
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
