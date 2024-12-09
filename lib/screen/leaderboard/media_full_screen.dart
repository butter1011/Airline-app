import 'dart:convert';

import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_screen.dart';
import 'package:airline_app/screen/leaderboard/widgets/emoji_box.dart';
import 'package:airline_app/screen/leaderboard/widgets/feedback_card.dart';
import 'package:airline_app/screen/leaderboard/widgets/next_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/previous_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class MediaFullScreen extends ConsumerStatefulWidget {
  const MediaFullScreen({super.key});

  @override
  ConsumerState<MediaFullScreen> createState() => _MediaFullScreenState();
}

class _MediaFullScreenState extends ConsumerState<MediaFullScreen> {
  @override
  Widget build(BuildContext context) {
    CarouselSliderController buttonCarouselController =
        CarouselSliderController();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final List<String> imgList = args?['Images'] ?? [];
    int? selectedEmojiIndex;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              if (imgList.length == 1)
                Container(
                  height: 594.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgList[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 594.0,
                  ),
                  items: imgList.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  carouselController: buttonCarouselController,
                ),
              if (imgList.length > 1) ...[
                Positioned(
                  top: 281,
                  right: 24,
                  child: InkWell(
                    onTap: () => buttonCarouselController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear),
                    child: const NextButton(),
                  ),
                ),
                Positioned(
                  top: 281,
                  left: 24,
                  child: InkWell(
                    onTap: () => buttonCarouselController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear),
                    child: const PreviousButton(),
                  ),
                ),
              ],
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
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
                        backgroundImage:
                            (args?['Avatar'] != '' && args?['Avatar'] != null)
                                ? NetworkImage(args?['Avatar'] ?? '')
                                : const AssetImage("assets/images/avatar_1.png")
                                    as ImageProvider,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args?['Name'] ?? '',
                          style: AppStyles.textStyle_14_600,
                        ),
                        Text(
                          args?['Date'] ?? '',
                          style: AppStyles.textStyle_14_400
                              .copyWith(color: const Color(0xFF02020A)),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const VerifiedButton(),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Text(
                      "Was in ",
                      style: AppStyles.textStyle_14_400
                          .copyWith(color: const Color(0xFF38433E)),
                    ),
                    Text(
                      "${args?['Usedairport'] ?? ''}, ",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      'Premium Economy',
                      style: AppStyles.textStyle_14_600,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  args?['Content'] ?? '',
                  style: AppStyles.textStyle_14_400,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await BottomSheetHelper.showScoreBottomSheet(context);
                      },
                      icon: Image.asset('assets/icons/share.png'),
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final RenderBox button =
                                context.findRenderObject() as RenderBox;
                            final index = await EmojiBox.showCustomDialog(
                                context, button);

                            if (index != null) {
                              setState(() {
                                ref
                                    .read(selectedEmojiProvider(
                                            args?['feedbackId'] ?? '')
                                        .notifier)
                                    .state = index + 1;
                              });

                              try {
                                final response = await http.post(
                                  Uri.parse('/api/v1/airline-review/update'),
                                  headers: {
                                    'Content-Type': 'application/json',
                                    'Accept': 'application/json',
                                  },
                                  body: jsonEncode({
                                    'feedbackId': args?['feedbackId'],
                                    'user_id': args?['user_id'],
                                    'reactionType': ref
                                        .watch(selectedEmojiProvider(
                                                args?['feedbackId'] ?? '')
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
                                                    args?['feedbackId'] ?? '')
                                                .notifier)
                                            .state =
                                        jsonDecode(response.body)['data']
                                                ['rating']
                                            .length;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Failed to update reaction')),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Something went wrong')),
                                );
                              }
                            }
                          },
                          icon: selectedEmojiIndex != 0
                              ? SvgPicture.asset(
                                  'assets/icons/emoji_${ref.watch(selectedEmojiProvider(args?['feedbackId'] ?? '').notifier).state}.svg',
                                  width: 24,
                                  height: 24,
                                )
                              : const Icon(Icons.thumb_up_outlined),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${ref.watch(selectedEmojiNumberProvider(args?['feedbackId'] ?? '').notifier).state}',
                          style: AppStyles.textStyle_14_600,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerifiedButton extends StatelessWidget {
  const VerifiedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 24,
      decoration: BoxDecoration(
          color: const Color(0xff181818),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text("Verified",
            style: GoogleFonts.getFont("Schibsted Grotesk",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.5,
                color: Colors.white)),
      ),
    );
  }
}
