import 'package:dio/dio.dart';
import 'package:airline_app/utils/global_variable.dart';

class UserReviewService {
  final Dio _dio = Dio();

  Future<dynamic> getUserReviews(String userId) async {
    try {
      final response = await _dio.get(
        '$apiUrl/api/v2/user-reviews',
        queryParameters: {
          'userId': userId,
        },
      );

      if (response.data['success']) {
        return response.data['data'];
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception(e is DioException
          ? e.response?.data['message'] ?? 'Failed to fetch user reviews data'
          : 'Failed to fetch user reviews data');
    }
  }
}
