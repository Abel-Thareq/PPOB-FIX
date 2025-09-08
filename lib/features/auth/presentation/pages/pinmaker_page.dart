import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ✅ Import halaman sukses
import 'package:ppob_app/features/auth/presentation/pages/RegistrationSuccessPage.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool _isLoading = false;

  String? _fullName; // nama lengkap user
  String? _initials; // inisial nama

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  /// Ambil profil user dari API
  Future<void> _fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");
      if (token == null) return;

      final base = ApiService.baseUrl.replaceAll(RegExp(r'/+$'), '');

      // 🔹 Pertama coba /auth/profile
      Uri uri = Uri.parse("$base/auth/profile");
      var resp = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (resp.statusCode != 200) {
        // 🔹 Jika gagal, coba /user
        uri = Uri.parse("$base/user");
        resp = await http.get(
          uri,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
      }

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);

        // Cek kemungkinan struktur API berbeda
        String? name;
        if (data is Map) {
          if (data.containsKey("data")) {
            name = data["data"]["name"];
          } else if (data.containsKey("user")) {
            name = data["user"]["name"];
          } else if (data.containsKey("name")) {
            name = data["name"];
          }
        }

        if (name != null && name.trim().isNotEmpty) {
          setState(() {
            _fullName = name;
            final parts = name?.trim().split(" ").where((e) => e.isNotEmpty).toList();
            if (parts!.isNotEmpty) {
              _initials = parts.map((e) => e[0]).take(2).join().toUpperCase();
            } else {
              _initials = "U";
            }
          });
        }
      }
    } catch (e) {
      debugPrint("Gagal fetch profil: $e");
    }
  }

  Future<void> _savePin() async {
    final pin = _pinController.text;
    final confirm = _confirmPinController.text;

    if (pin.length != 6) {
      _showError("PIN harus 6 digit");
      return;
    }
    if (pin != confirm) {
      _showError("Konfirmasi PIN tidak sesuai");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");

      if (token == null || token.isEmpty) {
        _showError("Token tidak ditemukan, silakan login kembali");
        return;
      }

      final result = await _requestSetPin(token: token, pin: pin);

      if (!mounted) return;

      if (result["success"] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegistrationSuccessPage()),
        );
      } else {
        _showError(result["message"] ?? "Gagal menyimpan PIN");
      }
    } catch (e) {
      _showError("Terjadi kesalahan: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Request set PIN
  Future<Map<String, dynamic>> _requestSetPin({
    required String token,
    required String pin,
  }) async {
    final base = ApiService.baseUrl.replaceAll(RegExp(r'/+$'), '');
    final uri = Uri.parse("$base/user/pin");

    http.Response resp;

    try {
      resp = await http
          .post(
            uri,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'pin': pin,
              'pin_confirmation': pin,
            }),
          )
          .timeout(const Duration(seconds: 20));
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Permintaan timeout. Coba lagi beberapa saat.',
        'status': 408,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server: $e',
      };
    }

    final status = resp.statusCode;
    final contentType = (resp.headers['content-type'] ?? '').toLowerCase();
    final bodyText = utf8.decode(resp.bodyBytes);

    final looksJson = contentType.contains('application/json') || contentType.contains('json');

    if (looksJson) {
      try {
        final parsed = jsonDecode(bodyText);
        final successFlag = (parsed is Map &&
                (parsed['success'] == true || (status >= 200 && status < 300))) ||
            (status >= 200 && status < 300);

        return {
          'success': successFlag,
          'message': parsed is Map
              ? (parsed['message'] ?? parsed['msg'] ?? parsed['error'])
              : null,
          'raw': parsed,
          'status': status,
        };
      } catch (_) {
        return {
          'success': status >= 200 && status < 300,
          'message': 'Respons server tidak dapat diproses (JSON tidak valid).',
          'raw': bodyText,
          'status': status,
        };
      }
    } else {
      return {
        'success': status >= 200 && status < 300,
        'message': status >= 200 && status < 300
            ? 'Berhasil, namun server mengembalikan non-JSON.'
            : 'Server mengembalikan non-JSON (status $status).',
        'raw': bodyText.length > 400 ? bodyText.substring(0, 400) : bodyText,
        'status': status,
      };
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Widget _buildPinField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      obscureText: true,
      maxLength: 6,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        counterText: "",
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.white,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),

              // Avatar + Nama (dinamis)
              CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFFE0E7FF),
                child: Text(
                  _initials ?? "U",
                  style: const TextStyle(
                    color: Color(0xFF5B5B5B),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _fullName ?? "Memuat...",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),

              // Input PIN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Masukkan PIN Anda"),
                    const SizedBox(height: 8),
                    _buildPinField(_pinController, "••••••"),
                    const SizedBox(height: 20),
                    const Text("Konfirmasi PIN Anda"),
                    const SizedBox(height: 8),
                    _buildPinField(_confirmPinController, "••••••"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Button Simpan
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5938FB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _savePin,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Simpan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}