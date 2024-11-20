import 'package:airline_app/utils/global_variable.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class FeedbackController {
  Future<List<dynamic>> fetchReviews() async {
    try {
      final response = await http.get(Uri.parse(
          '${apiUrl}/api/v2/airline-reviews'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (error) {
      return [
        {'success': false, 'message': error.toString()}
      ];
    }
  }
}
