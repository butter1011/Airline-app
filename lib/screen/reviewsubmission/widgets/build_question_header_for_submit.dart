import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BuildQuestionHeaderForSubmit extends StatelessWidget {
  const BuildQuestionHeaderForSubmit({
    super.key,
    required this.subTitle,
    required this.title,
    required this.airlineName,
    required this.airportName,
    required this.logoImage,
    required this.backgroundImage,
  });
  final String subTitle;
  final String airlineName;
  final String airportName;
  final String logoImage;
  final String backgroundImage;

  final String title;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/airport.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color:
              Color(0xff181818).withOpacity(0.95), // Black overlay with opacity
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (logoImage.isNotEmpty)
                        Container(
                          height: 40,
                          decoration: AppStyles.circleDecoration,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(logoImage)),
                        ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          airlineName,
                          style: AppStyles.oswaldTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (logoImage.isNotEmpty)
                        Container(
                          height: 40,
                          decoration: AppStyles.circleDecoration,
                          child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(logoImage)),
                        ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          airportName,
                          style: AppStyles.oswaldTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                title,
                style: AppStyles.textStyle_18_600
                    .copyWith(color: Color(0xffF9F9F9)),
              ),
              Text(
                subTitle,
                style: AppStyles.textStyle_15_600
                    .copyWith(color: Color(0xffC1C7C4)),
              ),
              SizedBox(
                height: 32,
              ),
              Image.asset(
                "assets/images/step_progress_indicator_white.png",
                width: screenSize.width * 0.8,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: 4,
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
