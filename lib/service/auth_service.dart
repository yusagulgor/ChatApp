import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  late Dio _dio;

  AuthService() {
    final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:5000';

    _dio = Dio(
      BaseOptions(
        baseUrl: "$apiUrl/auth",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  Future<Map<String, dynamic>> register(String name, String password) async {
    try {
      final response = await _dio.post(
        "/register",
        data: {"name": name, "password": password},
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        return {"error": response.data.toString()};
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic> && data.containsKey('error')) {
          return {"error": data['error']};
        } else {
          return {"error": data.toString()};
        }
      }
      return {"error": e.message};
    }
  }

  Future<Map<String, dynamic>> login(String name, String password) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {"name": name, "password": password},
      );

      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        return {"error": response.data.toString()};
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic> && data.containsKey('error')) {
          return {"error": data['error']};
        } else {
          return {"error": data.toString()};
        }
      }
      return {"error": e.message};
    }
  }

  Future<String?> getUserData(String name, String password) async {
    final response = await AuthService().login(name, password);
    if (response.containsKey("name")) {
      return response["name"] as String;
    }

    if (response.containsKey("error")) {
      print("Hata ${response["error"]}");
    }
    return null;
  }
}
