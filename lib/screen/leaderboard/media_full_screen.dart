import 'package:airline_app/screen/leaderboard/widgets/emoji_box.dart';
import 'package:airline_app/screen/leaderboard/widgets/next_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/previous_button.dart';
import 'package:airline_app/screen/leaderboard/widgets/share_to_social.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaFullScreen extends StatefulWidget {
  const MediaFullScreen({super.key});

  @override
  State<MediaFullScreen> createState() => _MediaFullScreenState();
}

class _MediaFullScreenState extends State<MediaFullScreen> {
  final List<String> imgList = [
    'assets/images/Singapore.png',
    'assets/images/SriLankan.png',
    'assets/images/Fiji.png',
  ];

  @override
  Widget build(BuildContext context) {
    CarouselSliderController buttonCarouselController =
        CarouselSliderController();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 594.0,
                ),
                items: imgList.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        // Set width to infinity
                        // margin: EdgeInsets.symmetric(horizontal: 5),
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
                            AssetImage('assets/images/${args!['Avatar']}'),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args['Name'],
                          style: AppStyles.textStyle_14_600,
                        ),
                        Text(
                          args['Date'],
                          style: AppStyles.textStyle_14_400
                              .copyWith(color: Color(0xFF02020A)),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                VerifiedButton(),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Text(
                      "Was in ",
                      style: AppStyles.textStyle_14_400
                          .copyWith(color: Color(0xFF38433E)),
                    ),
                    Text(
                      "${args['Usedairport']}, ",
                      style: AppStyles.textStyle_14_600,
                    ),
                    Text(
                      'Premium Economy',
                      style: AppStyles.textStyle_14_600,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  args['Content'],
                  style: AppStyles.textStyle_14_400,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await BottomSheetHelper.showScoreBottomSheet(
                            context,
                          );
                        },
                        icon: Image.asset('assets/icons/share.png'),
                        color: Colors.black),
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
