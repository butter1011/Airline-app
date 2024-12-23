import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/models/boarding_pass.dart';

import 'package:airline_app/provider/boarding_passes_provider.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final _boardingPassController = BoardingPassController();
  MobileScannerController cameraController = MobileScannerController();
  bool hasScanned = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  String extractFlightNumber(String scanData) {
    RegExp flightNumberRegex = RegExp(r'[A-Z]{2}\s*\d{3,4}');
    Match? match = flightNumberRegex.firstMatch(scanData);
    return match?.group(0) ?? 'Flight number not found';
  }

  String extractDepartureTime(String scanData) {
    RegExp timeRegex = RegExp(r'\d{2}:\d{2}');
    Match? match = timeRegex.firstMatch(scanData);
    return match?.group(0) ?? 'Time not found';
  }

  String extractEntireDepartureTime(String scanData) {
    // Regular expression to match date and time in format YYYY-MM-DD HH:MM
    RegExp dateTimeRegex = RegExp(r'(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2})');
    Match? match = dateTimeRegex.firstMatch(scanData);

    // Return the matched date and time or a default message
    return match != null
        ? '${match.group(1)} ${match.group(2)}'
        : 'Date and time not found';
  }

  String extractArrivalTime(String scanData) {
    RegExp timeRegex = RegExp(r'\d{2}:\d{2}');
    Iterable<Match> matches = timeRegex.allMatches(scanData);
    if (matches.length >= 2) {
      return matches.elementAt(1).group(0) ?? 'Time not found';
    }
    return 'Time not found';
  }

  String extractDepartureAirport(String scanData) {
    RegExp airportRegex = RegExp(r'([A-Z]{3})');
    Iterable<Match> matches = airportRegex.allMatches(scanData);
    if (matches.isNotEmpty) {
      return matches.elementAt(0).group(1) ?? 'Departure airport not found';
    }
    return 'Departure airport not found';
  }

  String extractArrivalAirport(String scanData) {
    RegExp airportRegex = RegExp(r'([A-Z]{3})');
    Iterable<Match> matches = airportRegex.allMatches(scanData);
    if (matches.length >= 2) {
      return matches.elementAt(1).group(1) ?? 'Airport not found';
    }
    return 'Airport not found';
  }

  String extractClassOfTravel(String scanData) {
    RegExp classRegex =
        RegExp(r'(Business|First|Premium)', caseSensitive: false);
    Match? match = classRegex.firstMatch(scanData);
    return match?.group(1)?.toUpperCase() ?? 'Economy';
  }

  String extractAirline(String flightNumber) {
    return flightNumber.split(' ')[0];
  }

  String getVisitStatus(String departureEntireTime) {
    try {
      DateTime departureDate = DateTime.parse(departureEntireTime);
      DateTime now = DateTime.now();
      Duration difference = now.difference(departureDate);

      if (departureDate.isAfter(now)) {
        return "Upcoming";
      } else if (difference.inDays <= 20) {
        return "Recent";
      } else {
        return "Earlier";
      }
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Boarding Pass'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) async {
          if (!hasScanned && capture.barcodes.isNotEmpty) {
            hasScanned = true;
            final barcode = capture.barcodes.first;
            final String rawValue = barcode.rawValue ?? '';

            if (rawValue.isNotEmpty) {
              final flightNumber = extractFlightNumber(rawValue);
              final departureTime = extractDepartureTime(rawValue);
              final departureEntireTime = extractEntireDepartureTime(rawValue);
              final arrivalTime = extractArrivalTime(rawValue);
              final departureAirportCode = extractDepartureAirport(rawValue);

              final arrivalAirportCode = extractArrivalAirport(rawValue);

              final classOfTravel = extractClassOfTravel(rawValue);
              final airlineCode = extractAirline(flightNumber);
              final visitStatus = getVisitStatus(departureEntireTime);

              if (ref
                  .read(boardingPassesProvider.notifier)
                  .hasFlightNumber(flightNumber)) {
                cameraController.stop();
                Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Flight $flightNumber already exists in your review list',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: AppStyles.mainColor,
                  ),
                );
                hasScanned = false; // Reset to allow new scan
                return;
              }

              final newPass = BoardingPass(
                name: ref.read(userDataProvider)?['userData']['_id'],
                departureAirportCode: departureAirportCode,
                departureTime: departureTime,
                arrivalAirportCode: arrivalAirportCode,
                arrivalTime: arrivalTime,
                classOfTravel: classOfTravel,
                airlineCode: airlineCode,
                flightNumber: flightNumber,
                visitStatus: visitStatus,
              );
              final result =
                  await _boardingPassController.saveBoardingPass(newPass);
              if (result) {
                cameraController.stop();
                Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Boarding pass scanned successfully',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: AppStyles.mainColor,
                  ),
                );
              } else {
                cameraController.stop();
                Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
                SnackBar(
                  content: Text(
                    'Boarding pass not scanned',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: AppStyles.mainColor,
                );
              }
            }
          }
        },
      ),
    );
  }
}
