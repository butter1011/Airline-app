import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class QuestionFirstScreen extends StatelessWidget {
  const QuestionFirstScreen({super.key});

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
                        style: AppStyles.reviewTitleTextStyle,
                      ),
                      Text(
                        ' AIRLINES',
                        style: AppStyles.reviewTitleTextStyle,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "Tell us what you liked about your journey.",
                style: AppStyles.subtitleTextStyle
                    .copyWith(color: Color(0xffF9F9F9)),
              ),
              Text(
                'Your feedback helps us improve!',
                style: AppStyles.textButtonStyle
                    .copyWith(color: Color(0xffC1C7C4)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Japan Airways, 18/10/24, Premium Economy',
                style: AppStyles.textButtonStyle.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Tokyo > Bucharest',
                style: AppStyles.textButtonStyle.copyWith(color: Colors.white),
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
              style: AppStyles.cardTextStyle,
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
                          context, AppRoutes.questionsecondscreen);
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

class FeedbackOption extends StatefulWidget {
  final String iconUrl;
  final String label;

  FeedbackOption({required this.iconUrl, required this.label});

  @override
  _FeedbackOptionState createState() => _FeedbackOptionState();
}

class _FeedbackOptionState extends State<FeedbackOption> {
  bool _isClicked = false;

  void _toggleClick() {
    setState(() {
      _isClicked = !_isClicked; // Toggle the click state
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleClick, // Change color on tap
      child: Container(
        decoration: AppStyles.cardDecoration.copyWith(
          color: _isClicked
              ? AppStyles.mainColor
              : Colors.white, // Change color based on click state
        ),
        padding: EdgeInsets.only(
            bottom: 10, top: 16), // Add padding for better spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: AppStyles.cardDecoration.copyWith(
                color: AppStyles.mainColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(widget.iconUrl, height: 40),
            ),
            SizedBox(height: 6),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: AppStyles.cardTextStyle, // Optional styling
            ),
          ],
        ),
      ),
    );
  }
}
