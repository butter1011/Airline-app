import 'dart:convert';

import 'package:airline_app/models/airline_review_model.dart';
import 'package:airline_app/models/airport_review_model.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:http/http.dart' as http;

class AirportReviewController {
  Future<bool> saveReview(AirportReviewModel review) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/v1/airport-review'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(review.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception('Error: $errorMessage');
      }
    } catch (e) {
      print('Error saving review: $e');
      // Optionally show a user-friendly message
      return false;
    }
  }
}
