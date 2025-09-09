import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePINPage extends StatefulWidget {
  const ChangePINPage({super.key});

  @override
  State<ChangePINPage> createState() => _ChangePINPageState();
}

class _ChangePINPageState extends State<ChangePINPage> {
  final List<TextEditingController> _pinControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _pinFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(children: [_buildHeader(), _buildContent()]),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 16,
            top: 51,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "modipay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "SATU PINTU SEMUA PEMBAYARAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 170),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFE0E7FF),
              child: Text(
                'NL',
                style: TextStyle(
                  color: Color(0xFF5B5B5B),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nama Lengkap',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              'Masukan PIN lama Anda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _buildPinInput(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validatePin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C4DF4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Selanjutnya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Implement forgot PIN logic
              },
              child: const Text(
                'Lupa kode PIN',
                style: TextStyle(color: Color(0xFF6C4DF4), fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
          (index) => SizedBox(
            width: 45,
            height: 45,
            child: TextField(
              controller: _pinControllers[index],
              focusNode: _pinFocusNodes[index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF6C4DF4)),
                ),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.isNotEmpty && index < 5) {
                  _pinFocusNodes[index + 1].requestFocus();
                } else if (value.isEmpty && index > 0) {
                  _pinFocusNodes[index - 1].requestFocus();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _validatePin() {
    String oldPin = _pinControllers.map((c) => c.text).join();
    if (oldPin.length != 6) {
      _showErrorDialog('PIN harus 6 digit');
      return;
    }

    // lanjut ke halaman ubah PIN baru
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPINPage(oldPin: oldPin)),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class NewPINPage extends StatefulWidget {
  final String oldPin;
  const NewPINPage({super.key, required this.oldPin});

  @override
  State<NewPINPage> createState() => _NewPINPageState();
}

class _NewPINPageState extends State<NewPINPage> {
  final List<TextEditingController> _newPinControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<TextEditingController> _confirmPinControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _newPinFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  final List<FocusNode> _confirmPinFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in [..._newPinControllers, ..._confirmPinControllers]) {
      controller.dispose();
    }
    for (var node in [..._newPinFocusNodes, ..._confirmPinFocusNodes]) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _handleChangePIN() async {
    String newPin = _newPinControllers.map((c) => c.text).join();
    String confirmPin = _confirmPinControllers.map((c) => c.text).join();

    if (newPin.length != 6 || confirmPin.length != 6) {
      _showErrorDialog('PIN harus 6 digit');
      return;
    }
    if (newPin != confirmPin) {
      _showErrorDialog('PIN Baru dan Konfirmasi PIN tidak cocok');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");
      if (token == null) {
        _showErrorDialog("Token tidak ditemukan, silakan login kembali");
        return;
      }

      final base = ApiService.baseUrl.replaceAll(RegExp(r'/+$'), '');
      final uri = Uri.parse("$base/auth/pin");

      final resp = await http.post(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "pin": newPin,
          "pin_confirmation": confirmPin,
        }),
      );

      final data = jsonDecode(resp.body);

      if (resp.statusCode == 200 && data["success"] == true) {
        _showSuccessDialog();
      } else {
        _showErrorDialog(data["message"] ?? "Gagal mengubah PIN");
      }
    } catch (e) {
      _showErrorDialog("Terjadi kesalahan: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildPinInput(
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
          (index) => SizedBox(
            width: 45,
            height: 45,
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              keyboardType: TextInputType.number,
              maxLength: 1,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF6C4DF4)),
                ),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value.isNotEmpty && index < 5) {
                  focusNodes[index + 1].requestFocus();
                } else if (value.isEmpty && index > 0) {
                  focusNodes[index - 1].requestFocus();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sukses'),
        content: const Text('PIN berhasil diubah'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // close NewPINPage
              Navigator.pop(context); // close ChangePINPage
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          _buildHeader(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 16,
            top: 51,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "modipay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "SATU PINTU SEMUA PEMBAYARAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 170),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFE0E7FF),
              child: Text(
                'NL',
                style: TextStyle(
                  color: Color(0xFF5B5B5B),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nama Lengkap',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              'Masukan PIN baru Anda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _buildPinInput(_newPinControllers, _newPinFocusNodes),
            const SizedBox(height: 24),
            const Text(
              'Konfirmasi PIN baru Anda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _buildPinInput(_confirmPinControllers, _confirmPinFocusNodes),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleChangePIN,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C4DF4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}