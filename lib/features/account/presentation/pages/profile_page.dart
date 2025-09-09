import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ppob_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? token;
  int? userId;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _lokasiAktif = true;
  bool _perangkatAktif = true;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadTokenAndProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadTokenAndProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
    token = prefs.getString('auth_token')?.trim();
  });

    debugPrint("🔑 Token dari SharedPreferences (load): $token");

    if (token != null && token!.isNotEmpty) {
      await _fetchProfile();
    } else {
      debugPrint("⚠️ Token tidak ada saat load profile");
    }
  }

  Future<void> _fetchProfile() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiService.baseUrl}/auth/profile"),
        headers: {
          "Authorization": "Bearer ${token?.trim()}",
          "Accept": "application/json",
        },
      );

      debugPrint("📡 Fetch profile status: ${response.statusCode}");
      debugPrint("📡 Fetch profile body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data['data']?['user'];

        if (user != null) {
          setState(() {
            userId = user['id'];
            _nameController.text = user['name'] ?? user['name'] ?? '';
            _emailController.text = user['email'] ?? '';
            _phoneController.text = user['phone'] ?? '';
          });
        }
      } else {
        debugPrint("⚠️ Gagal fetch profile: ${response.body}");
      }
    } catch (e) {
      debugPrint("❌ Error fetch profile: $e");
    }
  }

  Future<void> _updateProfile() async {
    if (_isSubmitting) return;

    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama dan Email wajib diisi")),
      );
      return;
    }

    // 🔄 Ambil ulang token terbaru dari prefs
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('auth_token')?.trim();

    debugPrint("🔑 Token dari SharedPreferences (update): $token");

    if (token == null || token!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token tidak ditemukan. Silakan login ulang.")),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final url = "${ApiService.baseUrl}/auth/updateProfile";
      debugPrint("➡️ PUT $url");
      debugPrint("➡️ Authorization: Bearer $token");

      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
        }),
      );

      debugPrint("📡 Update profile status: ${response.statusCode}");
      debugPrint("📡 Update profile body: ${response.body}");
      debugPrint("📡 Headers dikirim: ${{
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      }}");

      if (!mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil berhasil diperbarui")),
        );
        await _fetchProfile();
      } else {
        final body = jsonDecode(response.body);
        final message = body['message'] ?? "Gagal memperbarui profil. Coba lagi.";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      debugPrint("❌ Error update profile: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan jaringan")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _deleteAccount() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin keluar dari akun ini?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text(
              "Keluar",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Berhasil keluar")),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomePage()),
      (route) => false,
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
                height: 140,
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
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar bulat
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _nameController.text.isNotEmpty
                            ? _nameController.text[0].toUpperCase()
                            : "NL",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5938FB),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _nameController.text.isNotEmpty
                        ? _nameController.text
                        : "Nama Lengkap",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Data Pribadi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildTextField("Nama Lengkap", _nameController, false),
                  const SizedBox(height: 12),
                  _buildTextField("Nomor HP", _phoneController, true),
                  const SizedBox(height: 12),
                  _buildTextField("Email", _emailController, false),

                  const SizedBox(height: 12),
                  _buildSwitchTile("Lokasi Saya", _lokasiAktif, (val) {
                    setState(() => _lokasiAktif = val);
                  }),
                  const SizedBox(height: 12),
                  _buildSwitchTile("Perangkat Saya", _perangkatAktif, (val) {
                    setState(() => _perangkatAktif = val);
                  }),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5938FB),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text(
                              "Update",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _deleteAccount,
                    child: const Text.rich(
                      TextSpan(
                        text: "Hapus akun? ",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                        children: [
                          TextSpan(
                            text: "Keluar",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
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

  Widget _buildTextField(
      String hint, TextEditingController controller, bool readOnly) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF5938FB), width: 1.2),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String label, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF5938FB),
          ),
        ],
      ),
    );
  }
}