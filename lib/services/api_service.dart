import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "https://thermostable-phlebotomic-miss.ngrok-free.dev/api";

  // ---------------- Register ----------------
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
    String? fullName,
    required String pin,
    required String pinConfirmation,
  }) async {
    final url = Uri.parse("$baseUrl/auth/register");

    final body = {
      "name": name,
      "full_name": fullName ?? name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "phone": phone ?? "",
      "pin": pin,
      "pin_confirmation": pinConfirmation,
    };

    print("📤 Register request ke $url");
    print("➡️ Body: ${jsonEncode(body)}");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("📥 Status Code: ${response.statusCode}");
    print("📥 Response Body: ${response.body}");

    final result = jsonDecode(response.body);

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
        print("❌ Logout error: $e");
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}