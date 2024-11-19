import 'package:airline_app/screen/leaderboard/widgets/emoji_box.dart';
import 'package:airline_app/screen/leaderboard/widgets/next_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/previous_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({super.key, required this.singleFeedback});

  final Map<String, dynamic> singleFeedback;
  

  @override
  Widget build(BuildContext context) {
  
    final List<String> images = List<String>.from([
      'review_abudhabi_1.png',
      'review_ethiopian_2.png',
      'review_turkish_1.png'
    ]); // Ensure it's a List<String>
    CarouselSliderController buttonCarouselController =
        CarouselSliderController();

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        width: 299,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: AppStyles.circleDecoration,
                  child: CircleAvatar(
                    radius: 20,
                    // backgroundImage:
                    //     AssetImage('assets/images/${singleFeedback['Avatar']}'),
                  ),
                ),
                SizedBox(width: 8),
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
            SizedBox(height: 12),
            Row(
              children: [
                Text('Flex with', style: AppStyles.textStyle_14_400),
                SizedBox(width: 6),
                Text(
                    singleFeedback['airline']['name'] +
                        ", " +
                        singleFeedback['classTravel'],
                    style: AppStyles.textStyle_14_600)
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Text('Flex from', style: AppStyles.textStyle_14_400),
                SizedBox(width: 6),
                Text(
                    singleFeedback['from']['country'] +
                        "->" +
                        singleFeedback['to']['country'],
                    style: AppStyles.textStyle_14_600)
              ],
            ),
            SizedBox(height: 11),
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 189,
                  ),
                  items: images.map((singleImage) {
                    return Builder(builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 189,
                          width: 299,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/$singleImage'), // Ensure image paths are correct
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    });
                  }).toList(),
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
            SizedBox(height: 11),
            Text(singleFeedback['comment'], style: AppStyles.textStyle_14_400),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await BottomSheetHelper.showScoreBottomSheet(context);
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
                    SizedBox(width: 8),
                    Text("9998", style: AppStyles.textStyle_14_600)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
