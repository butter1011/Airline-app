import 'package:airline_app/screen/leaderboard/widgets/emoji_box.dart';
import 'package:airline_app/screen/leaderboard/widgets/next_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/previous_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackCard extends StatefulWidget {
  const FeedbackCard({super.key, required this.singleFeedback});
  final Map<String, dynamic> singleFeedback;

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  int? selectedEmojiIndex;
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = List<String>.from([
      'review_abudhabi_1.png',
      'review_ethiopian_2.png',
      'review_turkish_1.png'
    ]); // Ensure it's a List<String>

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
                    backgroundImage: AssetImage('assets/images/avatar_1.png'),
                    // backgroundImage:
                    //     AssetImage('assets/images/${singleFeedback['Avatar']}'),
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.singleFeedback['reviewer']['name'],
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      'Rated 9/10 on ${DateTime.parse(widget.singleFeedback['date']).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date']).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date']).toLocal().toString().substring(2, 4)}',
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
                    '${widget.singleFeedback['airline']['name']}, ${widget.singleFeedback['classTravel']}',
                    style: AppStyles.textStyle_14_600)
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Text('Flex from', style: AppStyles.textStyle_14_400),
                SizedBox(width: 6),
                Text(
                    '${widget.singleFeedback['from']['name']} -> ${widget.singleFeedback['to']['name']}',
                    style: AppStyles.textStyle_14_600),
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
                  carouselController: buttonCarouselController,
                  items: images.map((singleImage) {
                    return Builder(builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 189,
                          width: 299,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/$singleImage'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    });
                  }).toList(),
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
            const SizedBox(height: 11),
            Text(widget.singleFeedback['comment'],
                style: AppStyles.textStyle_14_400),
            const SizedBox(height: 16),
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
                        final RenderBox button =
                            context.findRenderObject() as RenderBox;
                        final index =
                            await EmojiBox.showCustomDialog(context, button);
                        // Update selected emoji after dialog closes
                        setState(() {
                          selectedEmojiIndex = index != null ? index + 1 : null;
                        });
                      },
                      icon: selectedEmojiIndex != null
                          ? SvgPicture.asset(
                              'assets/icons/emoji_$selectedEmojiIndex.svg',
                              width: 24,
                              height: 24,
                            )
                          : Icon(Icons.thumb_up_outlined),
                    ),
                    SizedBox(width: 8),
                    Text(widget.singleFeedback["rating"].toString(),
                        style: AppStyles.textStyle_14_600),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
