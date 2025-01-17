import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BuildQuestionHeaderForAirline extends StatelessWidget {
  const BuildQuestionHeaderForAirline(
      {super.key,
      required this.subTitle,
      required this.logoImage,
      required this.airlineName,
      required this.classes,
      required this.from,
      required this.backgorundImage,
      required this.to});
  final String subTitle;
  final String logoImage;
  final String backgorundImage;
  final String airlineName;
  final String classes;
  final String from;
  final String to;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (backgorundImage.isNotEmpty)
          Positioned.fill(
            child: Image.asset(
              "assets/images/airport.png",
              fit: BoxFit.cover,
            ),
          ),
        Container(
          color:
              Color(0xff181818).withOpacity(0.75), // Black overlay with opacity
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (logoImage.isNotEmpty)
                    Container(
                      height: 40,
                      decoration: AppStyles.circleDecoration,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(logoImage),
                      ),
                    ),
                  SizedBox(height: 10),
                  Text(
                    airlineName,
                    style: AppStyles.oswaldTextStyle,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                subTitle,
                style: AppStyles.textStyle_18_600
                    .copyWith(color: Color(0xffF9F9F9)),
              ),
              Text(
                'Your feedback helps us improve!',
                style: AppStyles.textStyle_15_600
                    .copyWith(color: Color(0xffC1C7C4)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '$airlineName, $classes',
                style: AppStyles.textStyle_15_600.copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '$from > $to',
                style: AppStyles.textStyle_15_600.copyWith(color: Colors.white),
              ),
              Spacer(), // This will push the following container to the bottom
              Container(
                height: 24,
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24))),

                // Center text inside the container
              ),
            ],
          ),
        ),
      ],
    );
  }
}
