import 'dart:convert';

import 'package:airline_app/utils/global_variable.dart';
import 'package:http/http.dart' as http;

class GetAirportScoreController {
  Future<Map<String, dynamic>> getAirportScore() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/v2/airport-score'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch reviews data');
      }

      final data = jsonDecode(response.body);
      return {'success': true, 'data': data};
    } catch (error) {
      return {'success': false, 'message': error.toString()};
    }
  }
}
