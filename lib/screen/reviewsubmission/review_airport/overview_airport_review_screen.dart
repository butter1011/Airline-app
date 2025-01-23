import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/aviation_info_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OverviewAirportReviewScreen extends ConsumerStatefulWidget {
  const OverviewAirportReviewScreen({super.key});

  @override
  ConsumerState<OverviewAirportReviewScreen> createState() =>
      _OverviewAirportReviewScreenState();
}

class _OverviewAirportReviewScreenState
    extends ConsumerState<OverviewAirportReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final airlineData = ref.watch(aviationInfoProvider);
    final airportName = ref
        .watch(airlineAirportProvider.notifier)
        .getAirportName(airlineData.airport);
    final airlineName = ref
        .watch(airlineAirportProvider.notifier)
        .getAirlineName(airlineData.airline);
    final selectedClassOfTravel =
        ref.watch(aviationInfoProvider).selectedClassOfTravel;
    final dateRange = ref.watch(aviationInfoProvider).dateRange;
    final date = dateRange.isNotEmpty ? dateRange[0] : DateTime.now();

    return Scaffold(
        backgroundColor: const Color(0xFF3FD789),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.05),
                    SizedBox(
                      height: constraints.maxHeight * 0.95,
                      width: constraints.maxWidth,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight * 0.45,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/airport.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: 
                                    Text(
                                      airportName,
                                      style: AppStyles.oswaldTextStyle
                                          .copyWith(fontSize: 24),
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                                          
                                
                                ),
                              ),
                              Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight * 0.4,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/gradient.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            constraints.maxWidth * 0.03),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                constraints.maxHeight * 0.02),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "1",
                                                style: AppStyles
                                                    .textStyle_24_600
                                                    .copyWith(
                                                        color:
                                                            AppStyles.mainColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(width: 20),
                                              Image.asset(
                                                "assets/images/baggage.png",
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "2",
                                                style: AppStyles
                                                    .textStyle_24_600
                                                    .copyWith(
                                                        color:
                                                            AppStyles.mainColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                              SizedBox(width: 20),
                                              Image.asset(
                                                "assets/images/flight.png",
                                              ),
                                              SizedBox(width: 20),
                                              Text(
                                                "3",
                                                style: AppStyles
                                                    .textStyle_24_600
                                                    .copyWith(
                                                        color:
                                                            AppStyles.mainColor,
                                                        fontWeight:
                                                            FontWeight.w900),
                                              ),
                                            ]),
                                        SizedBox(
                                            height:
                                                constraints.maxHeight * 0.03),
                                        FittedBox(
                                          child: Text(
                                            "Tell us what you liked about your journey.",
                                            style: AppStyles.textStyle_18_600,
                                          ),
                                        ),
                                        FittedBox(
                                          child: Text(
                                            "Your feedback helps make every journey better!",
                                            style: AppStyles.textStyle_15_400,
                                          ),
                                        ),
                                        FittedBox(
                                          child: Text(
                                            '$airlineName, $selectedClassOfTravel',
                                            style: AppStyles.textStyle_15_500,
                                          ),
                                        ),
                                        FittedBox(
                                          child: Text(
                                            airportName,
                                            style: AppStyles.textStyle_15_500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomSheet: _bottomSheet());
  }

  Widget _bottomSheet() {
    return LayoutBuilder(builder: (context, constraints) {
      print(
          "This is constraints.maxwidth and maxheight ${constraints.maxWidth}  ${constraints.maxHeight}");
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: constraints.maxHeight * 0.1,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: constraints.maxWidth * 0.13,
                    height: constraints.maxWidth * 0.13,
                    decoration: AppStyles.circleDecoration
                        .copyWith(color: AppStyles.mainColor),
                    child: const Icon(
                      Icons.arrow_upward,
                      shadows: [Shadow(color: Colors.black, blurRadius: 3.0)],
                    ),
                  ),
                  SizedBox(width: constraints.maxWidth * 0.03),
                  Flexible(
                    child: Text(
                      "Select positive aspects",
                      style: AppStyles.textStyle_14_600,
                    ),
                  ),
                ],
              )),
          Container(
            height: 2,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.06,
                vertical: constraints.maxHeight * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: _NavigationButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonName: "Go back",
                        color: Colors.white)),
                SizedBox(width: constraints.maxWidth * 0.04),
                Expanded(
                    child: _NavigationButton(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.questionfirstscreenforairport);
                        },
                        buttonName: "Next",
                        color: Colors.white))
              ],
            ),
          )
        ],
      );
    });
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton(
      {required this.onTap, required this.buttonName, required this.color});
  final VoidCallback onTap;
  final String buttonName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        decoration: AppStyles.buttonDecoration
            .copyWith(color: color, borderRadius: BorderRadius.circular(28)),
        child: Center(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  buttonName == "Go back"
                      ? Icon(
                          Icons.arrow_back,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 3.0)
                          ],
                        )
                      : Text(""),
                  SizedBox(width: 8),
                  Text(
                    buttonName,
                    style: AppStyles.textStyle_15_600,
                  ),
                  SizedBox(width: 8),
                  buttonName == "Next"
                      ? Icon(
                          Icons.arrow_forward,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 3.0)
                          ],
                        )
                      : Text("")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
