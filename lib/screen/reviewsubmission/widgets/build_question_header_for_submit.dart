import 'package:airline_app/screen/reviewsubmission/widgets/emphasize_widget.dart';
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
            "assets/images/header.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    right: screenSize.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (logoImage.isNotEmpty)
                            Container(
                              height: 40,
                              decoration: AppStyles.circleDecoration,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(logoImage),
                              ),
                            ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              airlineName,
                              style: AppStyles.oswaldTextStyle.copyWith(
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (logoImage.isNotEmpty)
                            Container(
                              height: 40,
                              decoration: AppStyles.circleDecoration,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(logoImage),
                              ),
                            ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              airportName,
                              style: AppStyles.oswaldTextStyle.copyWith(
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: AppStyles.textStyle_18_600.copyWith(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subTitle,
                      style: AppStyles.textStyle_15_600.copyWith(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("1",
                      style: AppStyles.textStyle_18_600
                          .copyWith(color: Colors.white)),
                  Image.asset(
                    "assets/images/progress_flight.png",
                    width: screenSize.width * 0.3,
                    fit: BoxFit.fitWidth,
                  ),
                  Text("2",
                      style: AppStyles.textStyle_18_600
                          .copyWith(color: Colors.white)),
                  Image.asset(
                    "assets/images/progress_trunk.png",
                    width: screenSize.width * 0.3,
                    fit: BoxFit.fitWidth,
                  ),
                  EmphasizeWidget(number: 3),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 24,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
