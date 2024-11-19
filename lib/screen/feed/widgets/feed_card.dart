import 'package:airline_app/screen/leaderboard/widgets/category_reviews.dart';
import 'package:airline_app/screen/leaderboard/widgets/emoji_box.dart';
import 'package:airline_app/screen/leaderboard/widgets/next_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/previous_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/screen/profile/utils/review_json.dart';
import 'package:airline_app/utils/app_styles.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  const FeedCard({super.key, required this.singleFeedback});

  final Map<String, dynamic> singleFeedback;

  @override
  Widget build(BuildContext context) {
    print("This is singelFeedback =============> $singleFeedback");
    final images = [
      'review_abudhabi_1.png',
      'review_ethiopian_2.png',
      'review_turkish_1.png'
    ];

    // List<String>.from(singleFeedback['Image']); // Ensure it's a List<String>
    CarouselSliderController buttonCarouselController =
        CarouselSliderController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: AppStyles.circleDecoration,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/avatar_1.png'),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  singleFeedback['reviewer']['name'],
                  style: AppStyles.textStyle_14_600,
                ),
                Text(
                  'Rated 9/10 on ${DateTime.parse(singleFeedback['date']).toLocal().toString().substring(8, 10)}.${DateTime.parse(singleFeedback['date']).toLocal().toString().substring(5, 7)}.${DateTime.parse(singleFeedback['date']).toLocal().toString().substring(2, 4)}',
                  style: AppStyles.textStyle_14_400,
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        VerifiedButton(),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Text(
              'Flex with',
              style: AppStyles.textStyle_14_400,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              singleFeedback['airline']['name'],
              style: AppStyles.textStyle_14_600,
            )
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Text(
              'Flex From',
              style: AppStyles.textStyle_14_400,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              singleFeedback['from']['country'] +
                  " -> " +
                  singleFeedback['to']['country'],
              style: AppStyles.textStyle_14_600,
            )
          ],
        ),
        SizedBox(
          height: 11,
        ),
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                height: 189,
                autoPlay: false, // Optional: Set to true if you want auto-play
              ),
              items: images.map((singleImage) {
                return Builder(builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20.0), // Set your desired border radius
                    child: Container(
                      height: 260,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/$singleImage'), // Use singleImage directly
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                });
              }).toList(), // Convert the mapped items to a list
              carouselController: buttonCarouselController,
            ),
            Positioned(
              top: 79,
              right: 16,
              child: InkWell(
                onTap: () => buttonCarouselController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear),
                child: const NextButton(),
              ),
            ),
            Positioned(
              top: 79,
              left: 16,
              child: InkWell(
                onTap: () => buttonCarouselController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear),
                child: const PreviousButton(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 11,
        ),
        Text(
          singleFeedback['comment'],
          style: AppStyles.textStyle_14_400,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                await BottomSheetHelper.showScoreBottomSheet(
                  context,
                );
              },
              child: Image.asset('assets/icons/share.png'),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await EmojiBox.showCustomDialog(
                        context); // Pass context here
                  },
                  icon: Icon(Icons.thumb_up_outlined),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "9998",
                  style: AppStyles.textStyle_14_600,
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 2,
          color: AppStyles.littleBlackColor,
        )
      ],
    );
  }
}
