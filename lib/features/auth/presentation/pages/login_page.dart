import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/core/widgets/custom_text_field.dart';
import 'package:ppob_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:ppob_app/features/auth/presentation/pages/register_page.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  String? _deviceName;
  String? _osVersion;
  double? _latitude;
  double? _longitude;

  bool _deviceInfoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_deviceInfoInitialized) {
      _initDeviceInfo();
      _deviceInfoInitialized = true;
    }
  }

  /// Ambil info device
  Future<void> _initDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      final info = await deviceInfo.androidInfo;
      setState(() {
        _deviceName = "${info.manufacturer} ${info.model}";
        _osVersion = "Android ${info.version.release}";
      });
    } else {
      final info = await deviceInfo.iosInfo;
      setState(() {
        _deviceName = info.name;
        _osVersion = "${info.systemName} ${info.systemVersion}";
      });
    }
  }

  /// Ambil lokasi user
  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (_) {
      // Jika gagal ambil lokasi, biarkan null
    }
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}/auth/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (_osVersion != null) 'X-Device-OS': _osVersion!,
        },
        body: json.encode({
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
          "device_name": _deviceName ?? "Unknown Device",
          "latitude": _latitude,
          "longitude": _longitude,
        }),
      );

      final data = json.decode(response.body);
      debugPrint("Login response: $data");

      if (response.statusCode == 200 && data["success"] == true) {
        final token = data["data"]?["token"];

        if (token == null || token.toString().isEmpty) {
          _showError("Token tidak diterima dari server");
          setState(() => _isLoading = false);
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("auth_token", token.trim());

        // 🔥 Cek token setelah disimpan
        final savedToken = prefs.getString("auth_token");
        debugPrint("TOKEN dari API: $token");
        debugPrint("TOKEN tersimpan di SharedPreferences: $savedToken");

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      } else {
        _showError(data["message"] ?? "Login gagal");
      }
    } catch (e) {
      _showError("Terjadi kesalahan: $e");
    }

    setState(() => _isLoading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header pakai gambar
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.white,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // Isi konten scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    // Ilustrasi
                    Center(
                      child: SizedBox(
                        height: 250,
                        child: Image.asset(
                          'assets/images/login_page.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email
                    CustomTextField(
                      label: 'Email',
                      hint: 'Masukkan Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value == null || value.isEmpty ? "Email tidak boleh kosong" : null,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    CustomTextField(
                      label: 'Password',
                      hint: 'Masukkan Password',
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) =>
                          value == null || value.isEmpty ? "Password tidak boleh kosong" : null,
                    ),
                    const SizedBox(height: 12),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                          );
                        },
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tombol Masuk
                    CustomButton(
                      text: "Masuk",
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 16),

                    // Daftar Akun
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            "Daftar yuk",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}