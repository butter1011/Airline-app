import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class CairMap extends StatefulWidget {
  const CairMap({Key? key}) : super(key: key);

  @override
  State<CairMap> createState() => _CairMapState();
}

class _CairMapState extends State<CairMap> {
  MapboxMap? myMapboxMap;

  void _onMapCreated(MapboxMap map) {
    myMapboxMap = map;

    // Set initial camera position
    map.setCamera(CameraOptions(
      center: Point(coordinates: Position(-98.0, 39.5)), // Longitude, Latitude
      zoom: 2,
    ));

    // Optionally load a style (uncomment and choose a style)
    // map.loadStyleURI(Styles.MAPBOX_STREETS); // Load the Mapbox Streets style
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cair Map'),
      ),
      body: MapWidget(
        onMapCreated: _onMapCreated,
        cameraOptions: CameraOptions(
          center: Point(
              coordinates: Position(-98.0, 39.5)), // Initial camera position
          zoom: 4,
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set your Mapbox access token from environment variable
  String ACCESS_TOKEN = const String.fromEnvironment("ACCESS_TOKEN");
  MapboxOptions.setAccessToken(ACCESS_TOKEN);

  runApp(MaterialApp(
    home: CairMap(),
  ));
}
