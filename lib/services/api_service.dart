import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.5:8000/api";
  // ---------------- Register ----------------
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
    String? fullName, required String pin, required String pinConfirmation,
  }) async {
    final url = Uri.parse("$baseUrl/auth/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "full_name": fullName ?? name, // sesuai backend
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "phone": phone ?? "",
      }),
    );

    final result = jsonDecode(response.body);

    // backend balikin status 201 kalau sukses
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        result['success'] == true &&
        result['data']?['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', result['data']['token']);
    }

    return result;
  }

  // ---------------- Login ----------------
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
    required String deviceName,
  }) async {
    final url = Uri.parse("$baseUrl/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "device_name": deviceName,
      }),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200 && result['data']?['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', result['data']['token']);
    }

    return result;
  }

  // ---------------- Get Token ----------------
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // ---------------- Get Profile ----------------
  static Future<Map<String, dynamic>> getProfile() async {
    final token = await getToken();
    if (token == null) {
      return {"error": "No token found"};
    }

    final url = Uri.parse("$baseUrl/auth/profile");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    return jsonDecode(response.body);
  }

  // ---------------- Logout ----------------
  static Future<void> logout() async {
    final token = await getToken();
    if (token != null) {
      final url = Uri.parse("$baseUrl/auth/logout");
      try {
        await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );
      } catch (e) {
        // bisa log error kalau mau
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}