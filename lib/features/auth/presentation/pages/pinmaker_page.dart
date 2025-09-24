import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ppob_app/features/auth/presentation/pages/RegistrationSuccessPage.dart';

class CreatePinPage extends StatefulWidget {
  final String? fullName;

  const CreatePinPage({super.key, this.fullName});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final List<TextEditingController> _pinControllers =
      List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> _confirmControllers =
      List.generate(6, (_) => TextEditingController());

  bool _isLoading = false;

  String? _fullName;
  String? _initials;

  @override
  void initState() {
    super.initState();
    if (widget.fullName != null && widget.fullName!.isNotEmpty) {
      _setFullName(widget.fullName!);
    } else {
      _loadNameFromPrefs();
    }
  }

  @override
  void dispose() {
    for (final c in _pinControllers) {
      c.dispose();
    }
    for (final c in _confirmControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _setFullName(String name) {
    setState(() {
      _fullName = name;
      final parts = name.trim().split(" ").where((e) => e.isNotEmpty).toList();
      _initials = parts.isNotEmpty
          ? parts.map((e) => e[0]).take(2).join().toUpperCase()
          : "U";
    });
  }

  Future<void> _loadNameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString("reg_full_name");
    if (name != null && name.isNotEmpty) {
      _setFullName(name);
    }
  }

  String get _pin => _pinControllers.map((c) => c.text).join();
  String get _confirmPin => _confirmControllers.map((c) => c.text).join();

  Future<void> _savePin() async {
    print("➡️ _savePin DIPANGGIL");
    print("📌 PIN: $_pin | Confirm: $_confirmPin");

    if (_pin.length != 6) {
      _showError("PIN harus 6 digit");
      print("❌ PIN kurang dari 6 digit");
      return;
    }
    if (_pin != _confirmPin) {
      _showError("Konfirmasi PIN tidak sesuai");
      print("❌ Konfirmasi PIN tidak cocok");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();

      // 🔹 Ambil data registrasi dari prefs
      final name = prefs.getString("reg_full_name");
      final email = prefs.getString("reg_email");
      final phone = prefs.getString("reg_phone");
      final password = prefs.getString("reg_password");
      final passwordConfirm = prefs.getString("reg_password_confirm");

      print("📤 Data dari SharedPreferences:");
      print(" - Name: $name");
      print(" - Email: $email");
      print(" - Phone: $phone");
      print(" - Password: ${password != null ? "ADA" : "null"}");
      print(" - PasswordConfirm: $passwordConfirm");

      if (name == null || email == null || phone == null || password == null) {
        _showError("Data registrasi tidak ditemukan, silakan daftar ulang.");
        print("❌ Data registrasi tidak lengkap di prefs");
        return;
      }

      // 🔹 Log request yang akan dikirim
      final requestData = {
        "name": name,
        "full_name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirm ?? password,
        "pin": _pin,
        "pin_confirmation": _confirmPin,
      };
      print("📤 Request ke API: $requestData");

      // 🔹 Panggil API register (sekarang termasuk PIN)
      final response = await ApiService.registerUser(
        name: name,
        fullName: name,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirm ?? password,
        pin: _pin,
        pinConfirmation: _confirmPin,
      );

      print("🔑 Register Response dari API: $response");

      if (!mounted) return;

      if (response["success"] == true && response["data"]?["token"] != null) {
        final token = response["data"]["token"];
        await prefs.setString("auth_token", token);

        // Bersihkan data sementara
        prefs.remove("reg_full_name");
        prefs.remove("reg_email");
        prefs.remove("reg_phone");
        prefs.remove("reg_password");
        prefs.remove("reg_password_confirm");

        print("✅ Registrasi + Simpan PIN berhasil, navigasi ke success page");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const RegistrationSuccessPage()),
        );
      } else {
        _showError(response["message"] ?? "Gagal menyimpan PIN");
        print("❌ Response gagal: ${response["message"]}");
        if (response["errors"] != null) {
          print("🛑 Detail Errors: ${response["errors"]}");
        }
      }
    } catch (e) {
      _showError("Terjadi kesalahan: $e");
      print("🔥 Exception di _savePin: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  Widget _buildPinBoxes(List<TextEditingController> controllers) {
    return Row(
      children: List.generate(6, (i) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: AspectRatio(
              aspectRatio: 1,
              child: TextFormField(
                controller: controllers[i],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                obscureText: true,
                obscuringCharacter: "•",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.0,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                onChanged: (val) {
                  if (val.isNotEmpty && i < 5) {
                    FocusScope.of(context).nextFocus();
                  } else if (val.isEmpty && i > 0) {
                    FocusScope.of(context).previousFocus();
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  counterText: "",
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
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
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
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
                  const SizedBox(height: 12),
                  Text(
                    _fullName ?? "Memuat...",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 24),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Masukan PIN Anda"),
                  ),
                  const SizedBox(height: 12),
                  _buildPinBoxes(_pinControllers),

                  const SizedBox(height: 24),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Konfirmasi PIN Anda"),
                  ),
                  const SizedBox(height: 12),
                  _buildPinBoxes(_confirmControllers),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
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
        ],
      ),
    );
  }
}