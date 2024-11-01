import 'package:airline_app/screen/profile/profile_screen.dart';
import 'package:airline_app/screen/profile/utils/map_visit_confirmed_json.dart';
import 'package:airline_app/screen/profile/widget/basic_mapbutton.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapExpandScreen extends StatefulWidget {
  const MapExpandScreen({super.key});
  @override
  State<MapExpandScreen> createState() => _MapExpandScreenState();
}

class _MapExpandScreenState extends State<MapExpandScreen> {
  final MapController _mapController = MapController();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _currentPosition = position;
    });

    _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude), 4.0);
  }

  // LatLng latLng = const LatLng(48.8584, 16.2945);

  @override
  Widget build(BuildContext context) {
    final PageController pgcontroller = PageController(viewportFraction: 0.9);
    return Scaffold(
      body: Container(
        // Ensure the child is clipped to the border radius
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentPosition != null
                    ? LatLng(
                        _currentPosition!.latitude, _currentPosition!.longitude)
                    : LatLng(22, 22),
                initialZoom: 4,
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
                      point: _currentPosition != null
                          ? LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude)
                          : LatLng(22, 22),
                      width: 60,
                      height: 60,
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red.shade700,
                        size: 60,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              right: 24,
              top: 56,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfileScreen();
                  }));
                },
                child: Container(
                  decoration: AppStyles.circleDecoration
                      .copyWith(color: AppStyles.mainColor)
                      .copyWith(color: AppStyles.mainColor),
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/icons/1.png'),
                ),
              )),
          Positioned(
              bottom: 8,
              left: 8,
              right: 0,
              child: Container(
                height: 130,
                // width: 200,
                child: PageView.builder(
                    controller: pgcontroller,
                    itemCount: mabboxVisitConfirmedList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
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
                                  style: AppStyles.textStyle_15_600,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Your scored 9/10',
                                  style: AppStyles.textStyle_15_500,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ))
        ]),
      ),
    );
  }
}
