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

        /// Required, The loading type of the widget
        colors: [AppStyles.mainColor],

        /// Optional, The color collections
        strokeWidth: 2,

        /// Optional, The stroke of the line, only applicable to widget which contains line
        backgroundColor: Colors.transparent,

        /// Optional, Background of the widget
        pathBackgroundColor: Colors.pink,

        /// Optional, the stroke backgroundColor
      ),
    ));
  }
}
