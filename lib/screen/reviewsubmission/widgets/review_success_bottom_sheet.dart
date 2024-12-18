import 'dart:ui';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/review_score_icon.dart';
import 'package:gif/gif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showReviewSuccessBottomSheet(BuildContext context,
    VoidCallback onSuccess, String reviewButtonText) async {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return _ReviewSuccessContent(
        onSuccess: onSuccess,
        reviewButtonText: reviewButtonText,
      );
    },
  );
}

class _ReviewSuccessContent extends ConsumerStatefulWidget {
  final VoidCallback onSuccess;
  final String reviewButtonText;

  const _ReviewSuccessContent({
    required this.onSuccess,
    required this.reviewButtonText,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_ReviewSuccessContent> createState() =>
      _ReviewSuccessContentState();
}

class _ReviewSuccessContentState extends ConsumerState<_ReviewSuccessContent>
    with TickerProviderStateMixin {
  late final GifController controller;
  bool _showGif = true;

  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this);
    _startGifTimer();
  }

  void _startGifTimer() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _showGif = false);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userData = ref.watch(userDataProvider);
    final points = userData?["userData"]["points"];

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_showGif)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                height: 350,
                width: 350,
                child: Gif(
                  controller: controller,
                  image: const AssetImage("assets/images/success.gif"),
                  fit: BoxFit.contain,
                  onFetchCompleted: () {
                    controller.reset();
                    controller.forward();
                  },
                ),
              ),
            ),
          const SizedBox(height: 60),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            height: size.height * 0.37,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 27, bottom: 16, left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text("Your Score is 9",
                            style: AppStyles.textStyle_32_600),
                      ),
                      const SizedBox(height: 21),
                      Text(
                        "You've earned $points points",
                        style: AppStyles.textStyle_24_600
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Your feedback helps make every journey better!",
                        style: AppStyles.textStyle_14_400,
                      ),
                      const SizedBox(height: 18),
                      const Row(
                        children: [
                          ReviewScoreIcon(
                              iconUrl: 'assets/icons/review_cup.png'),
                          SizedBox(width: 16),
                          ReviewScoreIcon(
                              iconUrl: 'assets/icons/review_notification.png'),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(thickness: 2, color: Colors.black),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: NavButton(
                      text: widget.reviewButtonText,
                      onPressed: () => Navigator.pushNamed(
                          context, AppRoutes.reviewsubmissionscreen),
                      color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
