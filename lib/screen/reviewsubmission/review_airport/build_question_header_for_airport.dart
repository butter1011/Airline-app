import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/progress_widget.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildQuestionHeaderForAirport extends ConsumerWidget {
  const BuildQuestionHeaderForAirport({
    super.key,
    required this.subTitle,
    required this.title,
  });
  final String subTitle;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardingPassDetail = ref.watch(aviationInfoProvider);
    final String airportName = boardingPassDetail.departureData["name"] ?? "";
    final String departureCode =
        boardingPassDetail.departureData["iataCode"] ?? "";
    final String arrivalCode = boardingPassDetail.arrivalData["iataCode"] ?? "";
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/airport.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.black.withAlpha(180),
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
                  SizedBox(height: 10),
                  Text(
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
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text("$departureCode - $arrivalCode",
                      style: AppStyles.textStyle_15_600
                          .copyWith(color: Colors.white, shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                        )
                      ])),
                  SizedBox(height: 32),
                  Text(
                    title,
                    style: AppStyles.textStyle_18_600.copyWith(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2.0,
                          color: Colors.black.withAlpha(127),
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
              Spacer(),
              ProgressWidget(
                parent: 0,
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
