import 'dart:convert';

import 'package:http/http.dart' as http;

class GetAirlineController {
  Future<Map<String, dynamic>> getAirlineAirport() async {
    try {
      final response = await http.get(Uri.parse(
          'https://airline-backend-pi.vercel.app/api/v2/airline-airport'));

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch airline airport data');
      }

      final data = jsonDecode(response.body);
      return {'success': true, 'data': data};
    } catch (error) {
      return {'success': false, 'message': error.toString()};
    }
  }
}