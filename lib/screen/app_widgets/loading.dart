import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:airline_app/utils/app_styles.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  final List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 80,
      height: 80,
      child: LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader,
        colors: [AppStyles.mainColor],
        strokeWidth: 2,
        backgroundColor: Colors.transparent,
        pathBackgroundColor: Colors.pink,
      ),
    ));
  }
}
