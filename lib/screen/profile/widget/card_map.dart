import 'package:airline_app/provider/airline_airport_data_provider.dart';
import 'package:airline_app/provider/airline_airport_review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:airline_app/screen/profile/map_expand_screen.dart';
import 'package:airline_app/screen/profile/utils/map_visit_confirmed_json.dart';
import 'package:airline_app/screen/profile/widget/basic_mapbutton.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:geocoding/geocoding.dart';
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late MapController _mapController;
  Position? _currentPosition;
  bool _isLoading = true;
  LatLng? _startPosition;

  List<Marker> _airportMarkers = [];

  TextEditingController _searchController = TextEditingController();
List<Map<String, dynamic>> _searchResults = [];


  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    // Delay the location check until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocationPermission();
      _loadAirportMarkers();
    });
  }

  void _handleSearch(String query) {
  if (query.isEmpty) {
    setState(() {
      _searchResults = [];
    });
    return;
  }

  final airportReviewData = ref.watch(airlineAirportProvider).filteredList;
  final results = airportReviewData.where((airport) {
    final name = airport['name'].toString().toLowerCase();
    final location = airport['location'].toString().toLowerCase();
    return name.contains(query.toLowerCase()) || 
           location.contains(query.toLowerCase());
  }).toList();

  setState(() {
    _searchResults = results;
  });
}

Future<LatLng?> getLatLngFromLocation(String location) async {
  try {
    List<Location> locations = await locationFromAddress(location);
    if (locations.isNotEmpty) {
      return LatLng(locations.first.latitude, locations.first.longitude);
    }
  } catch (e) {
    debugPrint('Error getting coordinates for $location: $e');
  }
  return null;
}

  Future<void> _loadAirportMarkers() async {
    final airportData = ref.watch(airlineAirportProvider).airportData;
    ref
        .read(airlineAirportProvider.notifier)
        .getFilteredList('Airport', null, null);
final airportReviewData =ref
                                      .watch(airlineAirportProvider)
                                      .filteredList;

    List<Marker> markers = [];
    
    for (var airport in airportReviewData) {
      final location = airport['location'];

      final name = airport['name'] ;
      final score = airport['overall'] ;
      
      final coordinates = await getLatLngFromLocation(location);
      
      if (coordinates != null) {
        markers.add(
  Marker(
  point: coordinates,
  width: 200,
  height: 200,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_airport,
                color: Colors.blue.shade700,
                size: 40,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Score: $score',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
)

        );
      }
    }
    
       setState(() {
      _airportMarkers = markers;
    });}

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
            8.0,
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

  @override
  Widget build(BuildContext context) {
    final PageController pgcontroller = PageController(viewportFraction: 0.9);

    return Container(
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
   MarkerLayer(
      markers: _airportMarkers,
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
                right: 8,
                top: 8,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapExpandScreen()),
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
  right: 8,
  top: 60, // Position below the expand button
  child: Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
              final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom + 1);            },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: const Icon(Icons.add, color: Colors.blue),
              ),
            ),
            InkWell(
              onTap: () {
                final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom - 1);
              },
              child: Container(
                width: 40,
                height: 40,
                child: const Icon(Icons.remove, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
Positioned(
  top: 8,
  left: 8,
  right: 60,
  child: Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: TextField(
      controller: _searchController,
      onChanged: _handleSearch,
      decoration: InputDecoration(
        hintText: 'Search airports...',
        prefixIcon: const Icon(Icons.search, color: Colors.blue),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIcon: _searchController.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _handleSearch('');
              },
            )
          : null,
      ),
    ),
  ),
),

if (_searchResults.isNotEmpty)
  Positioned(
    top: 60,
    left: 8,
    right: 60,
    child: Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final airport = _searchResults[index];
          return ListTile(
            leading: const Icon(Icons.local_airport, color: Colors.blue),
            title: Text(airport['name']),
            subtitle: Text(airport['location']),
            onTap: () async {
              final coordinates = await getLatLngFromLocation(airport['location']);
              if (coordinates != null) {
                _mapController.move(coordinates, 12);
                _searchController.clear();
                _handleSearch('');
              }
            },
          );
        },
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
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
