import 'package:airline_app/screen/leaderboard/leaderboard_screen.dart';
import 'package:airline_app/screen/leaderboard/widgets/emoji_box.dart';
import 'package:airline_app/screen/leaderboard/widgets/next_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/previous_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/screen/profile/widget/basic_black_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';

// final selectedEmojiProvider =
//     StateProvider.family<int, String>((ref, feedbackId) => 0);

class FeedbackCard extends ConsumerStatefulWidget {
  const FeedbackCard({super.key, required this.singleFeedback});
  final Map<String, dynamic> singleFeedback;

  @override
  ConsumerState<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends ConsumerState<FeedbackCard> {
  int? selectedEmojiIndex;
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.singleFeedback['reviewer'] == null ||
        widget.singleFeedback['airline'] == null) {
      return Container(); // Return empty container if data is null
    }

    final userId = ref.watch(userDataProvider)?['userData']?['_id'];
    final selectedEmojiIndex =
        ref.watch(selectedEmojiProvider(widget.singleFeedback['_id'] ?? ''));
    final List<dynamic> images = widget.singleFeedback['images'] ?? [];

    return SizedBox(
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
                  backgroundImage: (widget.singleFeedback['reviewer']
                                  ['profilePhoto'] !=
                              '' &&
                          widget.singleFeedback['reviewer']['profilePhoto'] !=
                              null)
                      ? NetworkImage(
                          '${widget.singleFeedback['reviewer']['profilePhoto']}')
                      : const AssetImage("assets/images/avatar_1.png")
                          as ImageProvider,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.singleFeedback['reviewer']['name'] ?? '',
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                      style: AppStyles.textStyle_14_400_grey,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          BasicBlackButton(
              mywidth: 68,
              myheight: 24,
              myColor: Colors.black,
              btntext: "Verified"),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text('Flex with', style: AppStyles.textStyle_14_400_littleGrey),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                    '${widget.singleFeedback['airline']['name'].toString().split(' ')[0]}, ${widget.singleFeedback['classTravel']}',
                    style: AppStyles.textStyle_14_600),
              )
            ],
          ),
          SizedBox(height: 7),
          widget.singleFeedback['from'] != null
              ? Row(
                  children: [
                    Text('Flex from',
                        style: AppStyles.textStyle_14_400_littleGrey),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                          '${widget.singleFeedback['from']['name']} -> ${widget.singleFeedback['to']['name']}',
                          style: AppStyles.textStyle_14_600),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text('Flex in',
                        style: AppStyles.textStyle_14_400_littleGrey),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text('${widget.singleFeedback['airport']['name']}',
                          style: AppStyles.textStyle_14_600),
                    ),
                  ],
                ),
          SizedBox(height: 11),
          if (images.isNotEmpty)
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.mediafullscreen,
                        arguments: {
                          'userId': userId,
                          'feedbackId': widget.singleFeedback['_id'],
                          'Images': images,
                          'Name': widget.singleFeedback['reviewer']['name'],
                          'Avatar': widget.singleFeedback['reviewer']
                              ['profilePhoto'],
                          'Date':
                              'Rated 9/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                          'Usedairport': widget.singleFeedback['airline']
                              ['name'],
                          'Content': widget.singleFeedback['comment'] != null &&
                                  widget.singleFeedback['comment'] != ''
                              ? widget.singleFeedback['comment']
                              : '',
                          'rating': ((widget.singleFeedback["rating"]
                                      as Map<String, dynamic>?) ??
                                  {})
                              .length
                              .toString(),
                        });
                  },
                  child: images != null
                      ? CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 189,
                            enableInfiniteScroll: false,
                            scrollPhysics: NeverScrollableScrollPhysics(),
                          ),
                          carouselController: buttonCarouselController,
                          items: images.map((singleImage) {
                            return Builder(builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 189,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('$singleImage'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            });
                          }).toList(),
                        )
                      : Container(),
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
            )
          else
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.mediafullscreen,
                    arguments: {
                      'userId': userId,
                      'feedbackId': widget.singleFeedback['_id'],
                      'Images': images,
                      'Name': widget.singleFeedback['reviewer']['name'],
                      'Avatar': widget.singleFeedback['reviewer']
                          ['profilePhoto'],
                      'Date':
                          'Rated 9/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                      'Usedairport': widget.singleFeedback['airline']['name'],
                      'Content': widget.singleFeedback['comment'] != null &&
                              widget.singleFeedback['comment'] != ''
                          ? widget.singleFeedback['comment']
                          : '',
                      'rating': ((widget.singleFeedback["rating"]
                                  as Map<String, dynamic>?) ??
                              {})
                          .length
                          .toString(),
                    });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  height: 189,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/default.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 11),
          if (widget.singleFeedback['comment'] != null &&
              widget.singleFeedback['comment'] != '')
            Text(widget.singleFeedback['comment'],
                style: AppStyles.textStyle_14_400),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () async {
                  await BottomSheetHelper.showScoreBottomSheet(context);
                },
                icon: Image.asset('assets/icons/share.png'),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final RenderBox button =
                          context.findRenderObject() as RenderBox;
                      final index =
                          await EmojiBox.showCustomDialog(context, button);

                      if (index != null) {
                        setState(() {
                          ref
                              .read(selectedEmojiProvider(
                                      widget.singleFeedback['_id'] ?? '')
                                  .notifier)
                              .state = index + 1;
                        });

                        try {
                          // Update reaction in backend

                          final response = await http.post(
                            Uri.parse('$apiUrl/api/v1/airline-review/update'),
                            headers: {
                              'Content-Type': 'application/json',
                              'Accept': 'application/json',
                            },
                            body: jsonEncode({
                              'feedbackId': widget.singleFeedback['_id'],
                              'user_id': userId,
                              'reactionType': ref
                                  .watch(selectedEmojiProvider(
                                          widget.singleFeedback['_id'] ?? '')
                                      .notifier)
                                  .state,
                            }),
                          );

                          if (response.statusCode == 200) {
                            setState(() {
                              ref
                                  .read(reviewsAirlineProvider.notifier)
                                  .updateReview(
                                      jsonDecode(response.body)['data']);
                              ref
                                  .read(selectedEmojiNumberProvider(
                                          widget.singleFeedback['_id'] ?? '')
                                      .notifier)
                                  .state = jsonDecode(response.body)['data']
                                      ['rating']
                                  .length;
                            });
                          } else {
                            // Show error message if API call fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Failed to update reaction')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Something went wrong')),
                          );
                        }
                      } // Update selected emoji after dialog closes
                    },
                    icon: selectedEmojiIndex != 0
                        ? SvgPicture.asset(
                            'assets/icons/emoji_${ref.watch(selectedEmojiProvider(widget.singleFeedback['_id'] ?? '').notifier).state}.svg',
                            width: 24,
                            height: 24,
                          )
                        : Icon(Icons.thumb_up_outlined),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${ref.watch(selectedEmojiNumberProvider(widget.singleFeedback['_id'] ?? '').notifier).state}',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
