import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ppob_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String? token;
  String? userName;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  // cegah double-tap & tampilkan loading di tombol
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadTokenAndName();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadTokenAndName() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('auth_token');
    userName = prefs.getString('user_name');

    debugPrint('Token dari SharedPreferences: $token');
    debugPrint('User Name dari SharedPreferences: $userName');

    if (mounted) setState(() {});
  }

  Uri _buildEndpoint(String path) {
    // Sanitasi baseUrl agar tidak double slash
    final cleanBase = (ApiService.baseUrl).replaceAll(RegExp(r'/+$'), '');
    return Uri.parse('$cleanBase/$path');
  }

  bool _isJsonResponse(http.Response res) {
    final ct = res.headers['content-type'] ?? '';
    return ct.toLowerCase().contains('application/json');
  }

  String _extractMessageSafely(http.Response res,
      {String fallback = 'Terjadi kesalahan.'}) {
    try {
      if (res.body.isEmpty || !_isJsonResponse(res)) return fallback;
      final body = jsonDecode(res.body);
      if (body is Map && body['message'] is String) {
        return body['message'] as String;
      }
      if (body is Map && body['errors'] is Map) {
        final errors = (body['errors'] as Map).map(
          (k, v) => MapEntry<String, dynamic>(k.toString(), v),
        );
        // Ambil pesan error pertama yang tersedia (cek beberapa kemungkinan key)
        for (final key in [
          'old_password',
          'new_password',
          'new_password_confirmation',
          'password',
          'confirm_password'
        ]) {
          if (errors.containsKey(key) &&
              errors[key] is List &&
              errors[key].isNotEmpty) {
            final first = errors[key][0];
            if (first is String && first.trim().isNotEmpty) return first;
          }
        }
        // Fallback lain dari array error apa pun
        for (final entry in errors.entries) {
          final v = entry.value;
          if (v is List && v.isNotEmpty && v.first is String) {
            return v.first as String;
          }
        }
      }
      return fallback;
    } catch (e) {
      debugPrint('Gagal parsing pesan error: $e');
      return fallback;
    }
  }

  Future<void> _changePassword() async {
    if (_isSubmitting) return;

    // Validasi input di sisi klien
    if (_oldPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua kolom password harus diisi")),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak cocok")),
      );
      return;
    }

    if (_newPasswordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password baru minimal 8 karakter")),
      );
      return;
    }

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Token autentikasi tidak ditemukan. Silakan login ulang.")),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // PERUBAHAN: panggil route yang benar di backend (auth/change-password)
    final uri = _buildEndpoint('auth/change-password');
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    // PERUBAHAN: gunakan new_password & new_password_confirmation
    final body = jsonEncode({
      "old_password": _oldPasswordController.text,
      "new_password": _newPasswordController.text,
      "new_password_confirmation": _confirmPasswordController.text,
    });

    try {
      final response =
          await http.post(uri, headers: headers, body: body).timeout(
                const Duration(seconds: 25),
              );

      debugPrint("Change password status: ${response.statusCode}");
      debugPrint("Change password body: ${response.body}");

      if (!mounted) return;

      // Anggap sukses untuk semua 2xx
      if (response.statusCode >= 200 && response.statusCode < 300) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password berhasil diubah")),
        );
        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
        Navigator.maybePop(context);
      } else {
        final message = _extractMessageSafely(
          response,
          fallback: "Gagal mengubah password. Kode: ${response.statusCode}",
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } on TimeoutException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permintaan timeout, coba lagi.")),
      );
    } catch (e) {
      debugPrint("Error change password: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan jaringan, coba lagi")),
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
        content: const Text(
            "Apakah Anda yakin ingin menghapus akun ini? Tindakan ini tidak dapat dibatalkan."),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Token autentikasi tidak ditemukan. Silakan login ulang.")),
      );
      return;
    }

    try {
      final uri = _buildEndpoint('user');
      final response = await http
          .delete(uri, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          })
          .timeout(const Duration(seconds: 25));

      debugPrint("Delete account status: ${response.statusCode}");
      debugPrint("Delete account body: ${response.body}");

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 204) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');
        await prefs.remove('user_name');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Akun berhasil dihapus")),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const WelcomePage()),
          (route) => false,
        );
      } else {
        final msg = _extractMessageSafely(
          response,
          fallback: "Gagal menghapus akun. Kode: ${response.statusCode}",
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    } on TimeoutException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permintaan timeout, coba lagi.")),
      );
    } catch (e) {
      debugPrint("Error hapus akun: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan jaringan, coba lagi")),
      );
    }
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
                        (userName != null && userName!.isNotEmpty)
                            ? userName![0].toUpperCase()
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
                    (userName != null && userName!.isNotEmpty)
                        ? userName!
                        : "Nama Lengkap",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Ubah Password
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ubah Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildPasswordField(
                    "Password Lama",
                    _oldPasswordController,
                    _obscureOld,
                    onToggle: () {
                      setState(() {
                        _obscureOld = !_obscureOld;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPasswordField(
                    "Password Baru",
                    _newPasswordController,
                    _obscureNew,
                    onToggle: () {
                      setState(() {
                        _obscureNew = !_obscureNew;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildPasswordField(
                    "Konfirmasi Password Baru",
                    _confirmPasswordController,
                    _obscureConfirm,
                    onToggle: () {
                      setState(() {
                        _obscureConfirm = !_obscureConfirm;
                      });
                    },
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _changePassword,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
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
                            text: "Hapus",
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

  Widget _buildPasswordField(
    String hint,
    TextEditingController controller,
    bool obscureText, {
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}