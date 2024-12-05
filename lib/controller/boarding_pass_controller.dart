import 'dart:convert';
import 'package:airline_app/models/boarding_pass.dart';
import 'package:airline_app/utils/global_variable.dart';
import 'package:http/http.dart' as http;

class BoardingPassController {
  Future<bool> saveBoardingPass(BoardingPass boardingPass) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/v1/boarding-pass'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(boardingPass.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception('Error: $errorMessage');
      }
    } catch (e) {
      print('Error saving boading pass: $e');
      return false;
    }
  }

  Future<List<BoardingPass>> getBoardingPasses(String name) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/v2/boarding-pass?name=$name'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['boardingPasses']
            .map<BoardingPass>((json) => BoardingPass.fromJson(json))
            .toList();
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching boarding passes: $e');
      return [];
    }
  }

  Future<bool> updateBoardingPass(BoardingPass boardingPass) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/api/v1/boarding-pass/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(boardingPass.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? 'Unknown error';
        throw Exception('Error: $errorMessage');
      }
    } catch (e) {
      print('Error updating boarding pass: $e');
      return false;
    }
  }
}
