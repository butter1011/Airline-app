import 'dart:async';
import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/controller/fetch_flight_info_by_cirium.dart';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scanner_button_widgets.dart';
import 'scanner_error_widget.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    torchEnabled: true,
    useNewCameraSelector: true,
  );
  final FetchFlightInforByCirium _confirmBoardingPass =
      FetchFlightInforByCirium();
  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;
  Map<String, dynamic>? detailedBoardingPass;
  final _boardingPassController = BoardingPassController();
  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan a boarding pass!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }
    if (value.rawValue != null) {
      parseIataBarcode(value.rawValue ?? '');
    }
    return Text(
      'Unsupported barcode format: ${value.format}',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);
        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  String getVisitStatus(DateTime departureEntireTime) {
    try {
      DateTime now = DateTime.now();
      Duration difference = now.difference(departureEntireTime);

      if (departureEntireTime.isAfter(now)) {
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

  void parseIataBarcode(String rawValue) {
    try {
      RegExp regex = RegExp(r'([A-Z]{8})\s+(\d{4})\s+(\d{3}[A-Z])');
      Match? match = regex.firstMatch(rawValue);

      if (match == null) throw Exception('Invalid barcode format');

      String routeOfFlight = match.group(1) ?? '';
      String departureAirport = routeOfFlight.substring(0, 3);
      String carrier = routeOfFlight.substring(6, 8);
      String flightNumber = match.group(2) ?? '';
      String julianDateAndClassOfService = match.group(3) ?? '';
      String julianDate = julianDateAndClassOfService.substring(0, 3);
      String classOfServiceKey = julianDateAndClassOfService.substring(3, 4);
      String classOfService = classOfServiceKey == "F"
          ? "First"
          : classOfServiceKey == "R"
              ? "Premium Economy"
              : classOfServiceKey == "J"
                  ? "Business"
                  : classOfServiceKey == "Y"
                      ? "Economy"
                      : "Premium Economy";
      DateTime baseDate = DateTime(DateTime.now().year, 1, 0);
      DateTime date = baseDate.add(Duration(days: int.parse(julianDate)));
      // print(
          // "This is arguements for API 📍==>departureAirport: $departureAirport, carrier: $carrier, flightNumber: $flightNumber, date: $date, classOfService: $classOfService");
      // print("This is date time 🧵==> ${DateTime(DateTime.now().year, 1, 16)}");
      _confirmBoardingPass
          .fetchFlightInfo(
        carrier: carrier,
        flightNumber: flightNumber,
        flightDate: date,
        depatureAirport: departureAirport,
      )
          .then((value) async {
        if (mounted) {
          setState(() {
            detailedBoardingPass = value;
          });
          // print(
          //     "This is fetched data by Cirium API 🎪 : ============>  $value");
          if (value['flightStatuses'] != null &&
              value['flightStatuses'].isNotEmpty) {
            final departureAirportCode =
                value['flightStatuses'][0]['departureAirportFsCode'];

            final departureEntireTime = DateTime.parse(
                value['flightStatuses'][0]['departureDate']['dateLocal']);

            final departureTime =
                "${departureEntireTime.hour.toString().padLeft(2, '0')}:${departureEntireTime.minute.toString().padLeft(2, '0')}";

            final arrivalAirportCode =
                value['flightStatuses'][0]['arrivalAirportFsCode'];
            final arrivalEntireTime = DateTime.parse(
                value['flightStatuses'][0]['arrivalDate']['dateLocal']);
            final arrivalTime =
                "${arrivalEntireTime.hour}:${arrivalEntireTime.minute}";

            final airlineCode = value['flightStatuses'][0]['carrierFsCode'];
            final flightNumber =
                "$carrier ${value['flightStatuses'][0]['flightNumber']}";

            final visitStatus = getVisitStatus(departureEntireTime);

            // print(
                // "This is newPass : 🎃🎃 ============>  $departureAirportCode, $departureTime, $arrivalAirportCode, $arrivalTime, $classOfService, $airlineCode, $flightNumber, $visitStatus");

            final newPass = BoardingPass(
              name: ref.read(userDataProvider)?['userData']['_id'],
              departureAirportCode: departureAirportCode,
              departureTime: departureTime,
              arrivalAirportCode: arrivalAirportCode,
              arrivalTime: arrivalTime,
              classOfTravel: classOfService,
              airlineCode: airlineCode,
              flightNumber: flightNumber,
              visitStatus: visitStatus,
            );

            // print("This is newPass : 🎃 ============>  $newPass");
            final result =
                await _boardingPassController.saveBoardingPass(newPass);
            if (result) {
              Navigator.pushNamed(context, AppRoutes.reviewsubmissionscreen);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Boarding pass saved successfully',
                      style: TextStyle(color: Colors.black)),
                  backgroundColor: AppStyles.mainColor,
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No flight data found for the boarding pass',
                    style: TextStyle(color: Colors.black)),
                backgroundColor: AppStyles.mainColor,
              ),
            );
          }
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            detailedBoardingPass = {'error': error.toString()};
          });
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          detailedBoardingPass = {
            'error': 'Unable to parse barcode data: ${e.toString()}'
          };
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boarding Pass Scanner')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 150,
              color: Colors.black.withOpacity(0.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _buildBarcode(_barcode))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ToggleFlashlightButton(controller: controller),
                      StartStopMobileScannerButton(controller: controller),
                      SwitchCameraButton(controller: controller),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }
}
