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
  late MapController _mapController;
  Position? _currentPosition;
  bool _isLoading = true;
  LatLng? _startPosition;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    // Delay the location check until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocationPermission();
    });
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Location services are disabled.');
      }
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _showErrorSnackBar('Location permissions are denied');
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Location permissions are permanently denied');
      }
      return;
    }

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      if (mounted) {
        setState(() {
          _currentPosition = position;
          _isLoading = false;
        });

        // Ensure the map is rendered before moving
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted && _currentPosition != null) {
          _mapController.move(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            4.0,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Error getting location: $e');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  // LatLng latLng = const LatLng(48.8584, 16.2945);

  @override
  Widget build(BuildContext context) {
    final PageController pgcontroller = PageController(viewportFraction: 0.9);
    return Scaffold(
        body: Container(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _currentPosition != null
                        ? LatLng(_currentPosition!.latitude,
                            _currentPosition!.longitude)
                        : const LatLng(0, 0),
                    initialZoom: 4,
                    onTap: (tapPosition, point) {
                      setState(() {
                        // Change the type of _startPosition to LatLng
                        _startPosition = point;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2luZ2J1dHRlciIsImEiOiJjbTJwcTZtcngwb3gzMnJzMjk0amtrNG14In0.dauZLQQedNrrHuzb1sRxOw",
                    ),
                    if (_currentPosition != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(_currentPosition!.latitude,
                                _currentPosition!.longitude),
                            width: 60,
                            height: 60,
                            child: Icon(Icons.location_pin,
                                color: Colors.red.shade700, size: 60),
                          ),
                        ],
                      ),
                    if (_startPosition != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _startPosition!,
                            width: 40,
                            height: 40,
                            child: Icon(Icons.location_pin,
                                color: Colors.green.shade700, size: 60),
                          ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  },
                  child: Container(
                    decoration: AppStyles.circleDecoration,
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/icons/1.png'),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: -8,
                right: 0,
                child: SizedBox(
                  height: 130,
                  child: PageView.builder(
                    controller: pgcontroller,
                    itemCount: mabboxVisitConfirmedList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(16),
                        width: 278,
                        decoration: AppStyles.cardDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasicMapbutton(
                              mywidth: 138,
                              myheight: 28,
                              iconpath: 'assets/icons/check.png',
                              btntext: 'Visit Confirmed',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Long AirPort Name goes here',
                              style: AppStyles.textStyle_15_600,
                            ),
                            Text(
                              'Your scored 9/10',
                              style: AppStyles.textStyle_15_500,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
    ));
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
