import 'package:airline_app/screen/profile/map_expand_screen.dart';
import 'package:airline_app/screen/profile/utils/map_visit_confirmed_json.dart';
import 'package:airline_app/screen/profile/widget/basic_mapbutton.dart';
import 'package:airline_app/screen/profile/widget/button1.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController controller = MapController();
  LatLng latLng = const LatLng(48.8584, 26.2945);

  @override
  Widget build(BuildContext context) {
    final PageController pgcontroller = PageController(viewportFraction: 0.97);
    return Container(
      // Ensure the child is clipped to the border radius
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: latLng,
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                // tileBounds: bounds,
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/256/{z}/{x}/{y}@2x?access_token=sk.eyJ1Ijoia2luZ2J1dHRlciIsImEiOiJjbTJxN3J1a3owd2I1MmxzYjh1cmlrOTM1In0.Ezps4XCt-6SpPYpZY4jIog",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: latLng,
                    width: 60,
                    height: 60,
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red.shade700,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            right: 8,
            top: 8,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapExpandScreen();
                }));
              },
              child: Container(
                decoration: AppStyles.avatarDecoration,
                // color: Colors.blue,
                width: 40,
                height: 40,
                child: Image.asset('assets/icons/1.png'),
              ),
            )),
        Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              height: 120,
              // width: 200,
              child: PageView.builder(
                  controller: pgcontroller,
                  itemCount: mabboxVisitConfirmedList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          width: 278,
                          // height: 117,
                          decoration: AppStyles.cardDecoration,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BasicMapbutton(
                                      mywidth: 133,
                                      myheight: 24,
                                      iconpath: 'assets/icons/check.png',
                                      btntext: 'Visit Confirmed'),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Long AirPort Name goes here',
                                    style: AppStyles.textButtonStyle,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your scored 9/10',
                                    style: AppStyles.litteGrayTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    );
                  }),
            ))
      ]),
    );
  }
}
