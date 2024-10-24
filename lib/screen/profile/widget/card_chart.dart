import 'package:airline_app/screen/profile/utils/card_chart_json.dart';
import 'package:airline_app/screen/profile/widget/Button1.dart';
import 'package:flutter/material.dart';

class CardChart extends StatelessWidget {
  // const CardChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: btn_chartList.map((btnValue) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: ButtonChart(
            iconpath: btnValue['iconpath'],
            mywidth: btnValue['width'],
            btntext: btnValue['text'],
            // myColor: btnValue['myColor'],
            myheight: btnValue['height'],
          ),
        );
      }).toList(),
    );
  }
}
