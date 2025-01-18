import 'package:video_player/video_player.dart';
import 'package:airline_app/screen/leaderboard/leaderboard_screen.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaFullScreen extends ConsumerStatefulWidget {
  const MediaFullScreen({super.key});

  @override
  ConsumerState<MediaFullScreen> createState() => _MediaFullScreenState();
}

class _MediaFullScreenState extends ConsumerState<MediaFullScreen> {
  final Map<String, VideoPlayerController> _videoControllers = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initVideos();
    });
  }

  Future<void> _initVideos() async {
    setState(() {
      isLoading = true;
    });

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final List<dynamic> videos = args?['Videos'] ?? [];

    for (var video in videos) {
      try {
        final controller = VideoPlayerController.networkUrl(
          Uri.parse(video),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );

        await controller.initialize();
        controller.setLooping(true);

        setState(() {
          _videoControllers[video] = controller;
        });
      } catch (e) {
        print('Error initializing video $video: $e');
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    for (var controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildVideoPlayer(String videoUrl) {
    final controller = _videoControllers[videoUrl];

    if (controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(controller),
          IconButton(
            icon: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 50.0,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CarouselSliderController buttonCarouselController =
        CarouselSliderController();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final List<dynamic> imgList = args?['Images'] ?? [];
    final List<dynamic> videoList = args?['Videos'] ?? [];
    final List<dynamic> mediaList = [...imgList, ...videoList];
    final selectedEmojiIndex =
        ref.watch(selectedEmojiProvider(args?['feedbackId'] ?? ''));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              if (mediaList.isEmpty)
                Container(
                  height: 594.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/default.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 594.0,
                    enableInfiniteScroll: false,
                  ),
                  items: mediaList.map((media) {
                    return Builder(
                      builder: (BuildContext context) {
                        if (videoList.contains(media)) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: _buildVideoPlayer(media),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(media),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                  carouselController: buttonCarouselController,
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
