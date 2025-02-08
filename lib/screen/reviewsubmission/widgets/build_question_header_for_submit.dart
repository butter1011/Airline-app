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
    required this.parent,
  });
  final String subTitle;
  final String airlineName;
  final String airportName;
  final String logoImage;
  final String title;
  final int parent;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/header.png",
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
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (logoImage.isNotEmpty)
                            Container(
                              height: 36,
                              width: 36,
                              decoration: AppStyles.circleDecoration,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(logoImage),
                              ),
                            ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              airlineName,
                              style: AppStyles.italicTextStyle.copyWith(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (logoImage.isNotEmpty)
                            Container(
                              height: 36,
                              width: 36,
                              decoration: AppStyles.circleDecoration,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(logoImage),
                              ),
                            ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              airportName,
                              style: AppStyles.italicTextStyle.copyWith(
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
              SizedBox(height: 16),
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
                  parent == 0
                      ? EmphasizeWidget(number: 1)
                      : Text("1",
                          style: AppStyles.textStyle_18_600
                              .copyWith(color: Colors.white)),
                  Image.asset(
                    "assets/images/progress_flight.png",
                    width: screenSize.width * 0.3,
                    fit: BoxFit.fitWidth,
                  ),
                  parent == 1
                      ? EmphasizeWidget(number: 2)
                      : Text("2",
                          style: AppStyles.textStyle_18_600
                              .copyWith(color: Colors.white)),
                  Image.asset(
                    "assets/images/progress_trunk.png",
                    width: screenSize.width * 0.3,
                    fit: BoxFit.fitWidth,
                  ),
                  parent == 2
                      ? EmphasizeWidget(number: 3)
                      : Text("3",
                          style: AppStyles.textStyle_18_600
                              .copyWith(color: Colors.white)),
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
