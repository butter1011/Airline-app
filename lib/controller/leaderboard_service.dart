import 'package:dio/dio.dart';
import 'package:airline_app/utils/global_variable.dart';

class LeaderboardService {
  final Dio _dio = Dio();

  Future<dynamic> getFilteredLeaderboard({
    required String airType,
    required String? flyerClass,
    required String? category,
    required List<String> continents,
    int page = 1,
  }) async {
    try {
      print('fetching filtered leaderboard data');
      final response = await _dio.get(
        '$apiUrl/api/v2/airline-list',
        queryParameters: {
          'airType': airType,
          'flyerClass': flyerClass,
          'category': category,
          'continents': continents.join(','),
          'page': page,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch filtered leaderboard data');
    }
  }
}
