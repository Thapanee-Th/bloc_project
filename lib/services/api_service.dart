import 'package:dio/dio.dart';
import 'jwt_service.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = "https://your-api.com";
  }

  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      '/login',
      data: {'username': username, 'password': password},
    );
    final token = response.data['token'];
    await JwtService.saveToken(token);
    return token;
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await JwtService.getToken();
    final response = await _dio.get(
      '/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }
}
