import 'package:airline_app/screen/profile/widget/basic_black_button.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';

class FeedbackCard extends ConsumerStatefulWidget {
  const FeedbackCard(
      {super.key, required this.singleFeedback, required this.thumbnailHeight});
  final Map<String, dynamic> singleFeedback;
  final double thumbnailHeight;

  @override
  ConsumerState<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends ConsumerState<FeedbackCard> {
  int? selectedEmojiIndex;
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  final Map<String, VideoPlayerController> _videoControllers = {};
  bool isFavorite = false;
  late int totalFavorites;

  @override
  void initState() {
    super.initState();
    // Initialize video controllers for all videos
    for (var video in widget.singleFeedback['videos'] ?? []) {
      _videoControllers[video] = VideoPlayerController.networkUrl(
        Uri.parse(video),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      )..initialize().then((_) {
          _videoControllers[video]?.setLooping(true);
        });
    }

    // Initialize favorite state and count
    final userId = ref.read(userDataProvider)?['userData']?['_id'];
    isFavorite = (widget.singleFeedback['rating'] as List).contains(userId);
    totalFavorites = (widget.singleFeedback['rating'] as List).length;
  }

  @override
  void dispose() {
    _videoControllers.forEach((_, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Widget _buildVideoPlayer(String videoUrl) {
    final controller = _videoControllers[videoUrl];
    if (controller == null) return Container();

    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          controller.play(); // Auto-play video
          controller.setLooping(true); // Ensure looping is enabled
          return AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.singleFeedback['reviewer'] == null ||
        widget.singleFeedback['airline'] == null) {
      return Container();
    }
    final userId = ref.watch(userDataProvider)?['userData']?['_id'];

    final List<dynamic> images = widget.singleFeedback['images'] ?? [];
    final List<dynamic> videos = widget.singleFeedback['videos'] ?? [];

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
                    '${widget.singleFeedback['airline']['name'].toString().length > 13 ? '${widget.singleFeedback['airline']['name'].toString().substring(0, 13)}..' : widget.singleFeedback['airline']['name']}, ${widget.singleFeedback['classTravel']}',
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
                          '${widget.singleFeedback['from']['city'].toString().length > 12 ? '${widget.singleFeedback['from']['city'].toString().substring(0, 12)}..' : widget.singleFeedback['from']['city']} -> ${widget.singleFeedback['to']['city'].toString().length > 12 ? '${widget.singleFeedback['to']['city'].toString().substring(0, 12)}..' : widget.singleFeedback['to']['city']}',
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
                      child: Text('${widget.singleFeedback['airport']['city']}',
                          style: AppStyles.textStyle_14_600),
                    ),
                  ],
                ),
          SizedBox(height: 11),
          if (images.isNotEmpty || videos.isNotEmpty)
            Stack(
              children: [
                widget.singleFeedback['from'] != null
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.mediafullscreen,
                              arguments: {
                                'userId': userId,
                                'feedbackId': widget.singleFeedback['_id'],
                                'Images': images,
                                'Videos': videos,
                                'Name': widget.singleFeedback['reviewer']
                                    ['name'],
                                'Avatar': widget.singleFeedback['reviewer']
                                    ['profilePhoto'],
                                'Date':
                                    'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                                'Usedairport': widget.singleFeedback['airline']
                                    ['name'],
                                'Content': widget.singleFeedback['comment'] !=
                                            null &&
                                        widget.singleFeedback['comment'] != ''
                                    ? widget.singleFeedback['comment']
                                    : '',
                                'rating': totalFavorites.toString(),
                              });
                        },
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 189,
                            enableInfiniteScroll: false,
                          ),
                          carouselController: buttonCarouselController,
                          items: [...images, ...videos].map((mediaItem) {
                            return Builder(builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 189,
                                  child: videos.contains(mediaItem)
                                      ? _buildVideoPlayer(mediaItem)
                                      : Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage('$mediaItem'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            });
                          }).toList(),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.mediafullscreen,
                              arguments: {
                                'userId': userId,
                                'feedbackId': widget.singleFeedback['_id'],
                                'Images': images,
                                'Videos': videos,
                                'Name': widget.singleFeedback['reviewer']
                                    ['name'],
                                'Avatar': widget.singleFeedback['reviewer']
                                    ['profilePhoto'],
                                'Date':
                                    'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                                'Usedairport': widget.singleFeedback['airport']
                                    ['name'],
                                'Content': widget.singleFeedback['comment'] !=
                                            null &&
                                        widget.singleFeedback['comment'] != ''
                                    ? widget.singleFeedback['comment']
                                    : '',
                                'rating': totalFavorites.toString(),
                              });
                        },
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 189,
                            enableInfiniteScroll: false,
                          ),
                          carouselController: buttonCarouselController,
                          items: [...images, ...videos].map((mediaItem) {
                            return Builder(builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 189,
                                  child: videos.contains(mediaItem)
                                      ? _buildVideoPlayer(mediaItem)
                                      : Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage('$mediaItem'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            });
                          }).toList(),
                        ),
                      ),
              ],
            )
          else
            widget.singleFeedback['from'] != null
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mediafullscreen,
                          arguments: {
                            'userId': userId,
                            'feedbackId': widget.singleFeedback['_id'],
                            'Images': images,
                            'Videos': videos,
                            'Name': widget.singleFeedback['reviewer']['name'],
                            'Avatar': widget.singleFeedback['reviewer']
                                ['profilePhoto'],
                            'Date':
                                'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                            'Usedairport': widget.singleFeedback['airline']
                                ['name'],
                            'Content':
                                widget.singleFeedback['comment'] != null &&
                                        widget.singleFeedback['comment'] != ''
                                    ? widget.singleFeedback['comment']
                                    : '',
                            'rating':
                                ((widget.singleFeedback["rating"] as List?) ??
                                        [])
                                    .length
                                    .toString(),
                          });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: widget.thumbnailHeight,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/default.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mediafullscreen,
                          arguments: {
                            'userId': userId,
                            'feedbackId': widget.singleFeedback['_id'],
                            'Images': images,
                            'Videos': videos,
                            'Name': widget.singleFeedback['reviewer']['name'],
                            'Avatar': widget.singleFeedback['reviewer']
                                ['profilePhoto'],
                            'Date':
                                'Rated ${(widget.singleFeedback['score'] ?? 0).toStringAsFixed(1)}/10 on ${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(8, 10)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(5, 7)}.${DateTime.parse(widget.singleFeedback['date'] ?? DateTime.now().toString()).toLocal().toString().substring(2, 4)}',
                            'Usedairport': widget.singleFeedback['airport']
                                ['name'],
                            'Content':
                                widget.singleFeedback['comment'] != null &&
                                        widget.singleFeedback['comment'] != ''
                                    ? widget.singleFeedback['comment']
                                    : '',
                            'rating':
                                ((widget.singleFeedback["rating"] as List?) ??
                                        [])
                                    .length
                                    .toString(),
                          });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: widget.thumbnailHeight,
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
          SizedBox(
            height: 40,
            child: Text(
              widget.singleFeedback['comment'] ?? '',
              style: AppStyles.textStyle_14_400,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          // buildEmojiRatings(uniqueRatings),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(
              //   onPressed: () async {
              //     // await BottomSheetHelper.showScoreBottomSheet(context);
              //     sharedFunction("https://airlinereviewapp.com");
              //   },
              //   icon: Image.asset('assets/icons/share.png'),
              // ),
              widget.singleFeedback['from'] != null
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isFavorite = !isFavorite;

                              if (isFavorite) {
                                totalFavorites++;
                              } else {
                                totalFavorites--;
                              }
                            });

                            try {
                              // Update reaction in backend

                              final response = await http.post(
                                Uri.parse(
                                    '$apiUrl/api/v1/airline-review/update'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json',
                                },
                                body: jsonEncode({
                                  'feedbackId': widget.singleFeedback['_id'],
                                  'user_id': userId,
                                  'isFavorite': isFavorite,
                                }),
                              );

                              if (response.statusCode == 200) {
                                setState(() {
                                  ref
                                      .read(reviewsAirlineProvider.notifier)
                                      .updateReview(
                                          jsonDecode(response.body)['data']);
                                });
                              } else {
                                print('Failed to update reaction');
                                //  Show error message if API call fails
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //       content:
                                //           Text('Failed to update reaction')),
                                // );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Something went wrong')),
                              );
                            }
                          },
                          icon: isFavorite
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                        ),
                        SizedBox(width: 8),
                        AnimatedFlipCounter(
                          value: totalFavorites,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isFavorite = !isFavorite;
                              if (isFavorite) {
                                totalFavorites++;
                              } else {
                                totalFavorites--;
                              }
                            });

                            try {
                              // Update reaction in backend

                              final response = await http.post(
                                Uri.parse(
                                    '$apiUrl/api/v1/airport-review/update'),
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json',
                                },
                                body: jsonEncode({
                                  'feedbackId': widget.singleFeedback['_id'],
                                  'user_id': userId,
                                  'isFavorite': isFavorite,
                                }),
                              );

                              if (response.statusCode == 200) {
                                setState(() {
                                  ref
                                      .read(reviewsAirlineProvider.notifier)
                                      .updateReview(
                                          jsonDecode(response.body)['data']);
                                });
                              } else {
                                print('Failed to update reaction'); 
                                // Show error message if API call fails
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //       content:
                                //           Text('Failed to update reaction')),
                                // );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Something went wrong')),
                              );
                            }
                          },
                          icon: isFavorite
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                        ),
                        SizedBox(width: 8),
                        Text(
                          totalFavorites.toString(),
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
