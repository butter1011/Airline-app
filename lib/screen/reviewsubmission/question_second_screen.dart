import 'package:airline_app/screen/app_widgets/feedbackoption.dart';
import 'package:airline_app/screen/reviewsubmission/question_first_screen.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class QuestionSecondScreen extends StatelessWidget {
  const QuestionSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
        flexibleSpace: _buildHeader(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildFeedbackOptions(),
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Japan.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color:
              Color(0xff181818).withOpacity(0.75), // Black overlay with opacity
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/vector_japan.png"),
                  SizedBox(width: 8),
                  Column(
                    children: [
                      Text(
                        'JAPAN     ',
                        style: AppStyles.oswaldTextStyle,
                      ),
                      Text(
                        ' AIRLINES',
                        style: AppStyles.oswaldTextStyle,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "What could be improved?",
                style: AppStyles.textStyle_18_600
                    .copyWith(color: Color(0xffF9F9F9)),
              ),
              Text(
                'Your feedback helps us improve!',
                style: AppStyles.textStyle_15_600
                    .copyWith(color: Color(0xffC1C7C4)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Japan Airways, 18/10/24, Premium Economy',
                style: AppStyles.textStyle_15_600.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Tokyo > Bucharest',
                style: AppStyles.textStyle_15_600.copyWith(color: Colors.white),
              ),
              Spacer(), // This will push the following container to the bottom
              Container(
                height: 24,
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24))),

                // Center text inside the container
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackOptions() {
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
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  FeedbackOption(
                    iconUrl: 'assets/icons/review_icon_boarding.png',
                    label: 'Boarding and\nArrival Experience',
                  ),
                  FeedbackOption(
                    iconUrl: 'assets/icons/review_icon_comfort.png',
                    label: 'Comfort',
                  ),
                  FeedbackOption(
                    iconUrl: 'assets/icons/review_icon_cleanliness.png',
                    label: 'Cleanliness',
                  ),
                  FeedbackOption(
                    iconUrl: 'assets/icons/review_icon_onboard.png',
                    label: 'Onboard Service',
                  ),
                  FeedbackOption(
                    iconUrl: 'assets/icons/review_icon_food.png',
                    label: 'Food & Beverage',
                  ),
                  FeedbackOption(
                    iconUrl: 'assets/icons/review_icon_entertainment.png',
                    label: 'In-Flight\nEntertainment',
                  ),
                ],
              ),
            ),
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
