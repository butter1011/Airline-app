import 'dart:convert';

import 'package:airline_app/utils/global_variable.dart';
import 'package:http/http.dart' as http;

class GetReviewsAirlineController {
  Future<Map<String, dynamic>> getReviews() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/v2/airline-reviews'),
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
