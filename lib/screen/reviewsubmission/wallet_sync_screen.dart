import 'dart:io';

import 'package:airline_app/controller/boarding_pass_controller.dart';
import 'package:airline_app/controller/fetch_flight_info_by_cirium.dart';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/provider/user_data_provider.dart';
import 'package:airline_app/screen/reviewsubmission/widgets/nav_button.dart';
import 'package:airline_app/utils/app_localizations.dart';
import 'package:airline_app/utils/app_routes.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletSyncScreen extends ConsumerStatefulWidget {
  const WalletSyncScreen({super.key});

  @override
  ConsumerState<WalletSyncScreen> createState() => _WalletSyncScreenState();
}

class _WalletSyncScreenState extends ConsumerState<WalletSyncScreen> {
  final MobileScannerController _controller = MobileScannerController();
  final FetchFlightInforByCirium _confirmBoardingPass =
      FetchFlightInforByCirium();
  final _boardingPassController = BoardingPassController();
  Map<String, dynamic>? detailedBoardingPass;

  Future<void> _analyzeImageFromFile() async {
    try {
      final XFile? file =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (file == null || !mounted) return;

      final BarcodeCapture? barcodeCapture =
          await _controller.analyzeImage(file.path);

      if (mounted && barcodeCapture?.barcodes.isNotEmpty == true) {
        final String? rawValue = barcodeCapture?.barcodes.first.rawValue;
        if (rawValue != null) {
          parseIataBarcode(rawValue);
          print("This is the raw value scanned from barcode 🎇: $rawValue");
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error analyzing image: ${e.toString()}')),
        );
      }
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
      //     "This is arguements for API 📍==>departureAirport: $departureAirport, carrier: $carrier, flightNumber: $flightNumber, date: $date, classOfService: $classOfService");
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
          if (value['flightStatuses'] != null && value['flightStatuses'].isNotEmpty) {
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
            final flightNumber = "$carrier ${value['flightStatuses'][0]['flightNumber']}";

            final visitStatus = getVisitStatus(departureEntireTime);

            // print(
            //     "This is newPass : 🎃🎃 ============>  $departureAirportCode, $departureTime, $arrivalAirportCode, $arrivalTime, $classOfService, $airlineCode, $flightNumber, $visitStatus");

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

  void _launchGoogleWallet() async {
    // This is the URI scheme for Google Wallet
    const url = 'https://pay.google.com/gp/v/home';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // If Google Wallet is not installed, you might want to open the Play Store listing
      const fallbackUrl =
          'https://play.google.com/store/apps/details?id=com.google.android.apps.walletnfcrel';
      final Uri fallbackUri = Uri.parse(fallbackUrl);
      if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri);
      } else {
        throw 'Could not launch $url or $fallbackUrl';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.08,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate('Sync from Your Wallet'),
          style: AppStyles.textStyle_16_600,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 4.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          size: 48,
                          color: AppStyles.mainColor,
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppStyles.textStyle_16_600.copyWith(
                              height: 1.5,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "Please click on ",
                              ),
                              TextSpan(
                                text: "Upload Boarding Pass Screenshot",
                                style: TextStyle(color: AppStyles.mainColor),
                              ),
                              TextSpan(
                                text:
                                    " button to upload the screenshot of your boarding pass used during your travel.\n\n",
                              ),
                              TextSpan(
                                text:
                                    "If you don't have a screenshot, simply click on ",
                              ),
                              TextSpan(
                                text: "Move To Wallet",
                                style: TextStyle(color: AppStyles.mainColor),
                              ),
                              TextSpan(
                                text: " button to retrieve it.\n\n",
                              ),
                              TextSpan(
                                text: "Caution: ",
                                style: TextStyle(color: Colors.orange),
                              ),
                              TextSpan(
                                text:
                                    "Ensure that the screenshot clearly displays the barcode of your boarding pass.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                NavButton(
                  text: AppLocalizations.of(context)
                      .translate('Upload Boarding Pass Screenshot'),
                  onPressed: _analyzeImageFromFile,
                  color: AppStyles.mainColor,
                ),
                const SizedBox(height: 12),
                NavButton(
                  text:
                      AppLocalizations.of(context).translate('Move To Wallet'),
                  onPressed: _launchGoogleWallet,
                  color: AppStyles.mainColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
