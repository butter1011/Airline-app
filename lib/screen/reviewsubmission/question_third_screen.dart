import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_page_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class QuestionThirdScreen extends StatelessWidget {
  const QuestionThirdScreen({super.key});

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
            _buildFeedbackOptions(context),
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
              _buildHeaderTitle(),
              SizedBox(height: 32),
              _buildHeaderSubtitle(),
              SizedBox(height: 20),
              _buildFlightDetails(),
              Spacer(), // Pushes the following container to the bottom
              _buildBottomContainer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/vector_japan.png"),
        SizedBox(width: 8),
        Column(
          children: [
            Text('JAPAN', style: AppStyles.reviewTitleTextStyle),
            Text('AIRLINES', style: AppStyles.reviewTitleTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderSubtitle() {
    return Column(
      children: [
        Text("Share your experience",
            style:
                AppStyles.subtitleTextStyle.copyWith(color: Color(0xffF9F9F9))),
        Text('Your feedback helps us improve!',
            style:
                AppStyles.textButtonStyle.copyWith(color: Color(0xffC1C7C4))),
      ],
    );
  }

  Widget _buildFlightDetails() {
    return Column(
      children: [
        Text('Japan Airways, 18/10/24, Premium Economy',
            style: AppStyles.textButtonStyle.copyWith(color: Colors.white)),
        SizedBox(height: 4),
        Text('Tokyo > Bucharest',
            style: AppStyles.textButtonStyle.copyWith(color: Colors.white)),
      ],
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      height: 24,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
      ),
    );
  }

  Widget _buildFeedbackOptions(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Share your experience with other users (Optional)',
                style: AppStyles.cardTextStyle),
            SizedBox(height: 19),
            _buildMediaUploadOption(context),
            SizedBox(height: 20),
            _buildCommentsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaUploadOption(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: AppStyles.cardDecoration
          .copyWith(borderRadius: BorderRadius.circular(16)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            height: 48,
            width: 48,
            decoration: AppStyles.cardDecoration
                .copyWith(borderRadius: BorderRadius.circular(16)),
            child: Icon(Icons.file_upload_outlined)),
        SizedBox(height: 12),
        Text("Choose your media for upload", style: AppStyles.textButtonStyle)
      ]),
    );
  }

  Widget _buildCommentsSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Comments (Optional)", style: AppStyles.cardTextStyle),
        SizedBox(height: 6),
        Container(
            height: MediaQuery.of(context).size.height * 0.19,
            width: double.infinity,
            decoration: AppStyles.cardDecoration,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text("Some comment here",
                    style: AppStyles.textStyle_14_400))),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Column(
      children: [
        Divider(
            color: Colors.black,
            thickness: 2), // Using Divider for better semantics
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: NavPageButton(
                  text: 'Go back',
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                  icon: Icons.arrow_back,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: NavPageButton(
                  text: 'Next',
                  onPressed: () async {
                    Navigator.pushNamed(context, AppRoutes.leaderboardscreen);
                    // Show the bottom sheet before navigating
                    await _buildBottomSheet(context);
                    // Then navigate to the next screen
                  },
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _buildBottomSheet(BuildContext context) {
    print("🥉🥉🥉🥉=====>$context");
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.37,
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 27, bottom: 16, left: 24, right: 24),
                // Adjust height based on items
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text("Your Score is 9",
                            style: AppStyles.textStyle_32_600)),
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      "You’ve earned 100 points",
                      style: AppStyles.textStyle_24_600
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Your feedback helps make every journey better!",
                      style: AppStyles.textStyle_14_400,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        _ReviewScoreIcon(
                            iconUrl: 'assets/icons/review_cup.png'),
                        SizedBox(
                          width: 16,
                        ),
                        _ReviewScoreIcon(
                            iconUrl: 'assets/icons/review_notification.png'),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: NavButton(text: "Review airport", onPressed: () {}),
              )
            ],
          ),
        );
      },
    );
  }
}

class _ReviewScoreIcon extends StatefulWidget {
  const _ReviewScoreIcon({super.key, required this.iconUrl});
  final String iconUrl;

  @override
  State<_ReviewScoreIcon> createState() => __ReviewScoreIconState();
}

class __ReviewScoreIconState extends State<_ReviewScoreIcon> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        height: 40,
        decoration: AppStyles.avatarDecoration.copyWith(
            color: _isSelected ? AppStyles.mainButtonColor : Colors.white),
        child: Image.asset(widget.iconUrl),
      ),
    );
  }
}
