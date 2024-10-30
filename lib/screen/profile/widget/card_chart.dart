import 'package:airline_app/screen/profile/utils/card_chart_json.dart';
import 'package:airline_app/screen/profile/widget/button1.dart';
import 'package:airline_app/screen/profile/widget/review_button.dart';
import 'package:flutter/material.dart';

class CardChart extends StatelessWidget {
  // const CardChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 16, children: [
      ReviewButton(text: "Top Reviewer", color: Colors.white, score: 3)
    ]);
  }
}
