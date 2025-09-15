import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MessageService {
  late Dio _dio;

  MessageService() {
    final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:5000';
    _dio = Dio(
      BaseOptions(
        baseUrl: "$apiUrl/messages",
        receiveTimeout: const Duration(seconds: 10),
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  Future<Map<String, dynamic>> sendMessage({
    required String from,
    required String to,
    required String text,
  }) async {
    try {
      final response = await _dio.post(
        "/send",
        data: {"fromUserId": from, "toUserId": to, "text": text},
      );

      if (response.data is Map<String, dynamic>) {
        return response.data;
      }
      return {"error": response.data.toString()};
    } on DioException catch (e) {
      return {"error": e.message ?? "Bilinmeyen hata"};
    }
  }

  Future<List<dynamic>> getMessages({
    required String userId1,
    required String userId2,
  }) async {
    try {
      final response = await _dio.post(
        "/messages",
        data: {"userId1": userId1, "userId2": userId2},
      );

      if (response.data != null && response.data["messages"] != null) {
        final List<dynamic> messages =
            response.data["messages"] as List<dynamic>;
        return messages;
      }

      return [];
    } on DioException catch (e) {
      return [];
    }
  }
}
