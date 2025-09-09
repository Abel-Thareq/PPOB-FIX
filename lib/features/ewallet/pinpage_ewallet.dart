import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ppob_app/services/api_service.dart';
import 'struk_ewallet_page.dart';

class PinEWalletPage extends StatefulWidget {
  final String ewalletName; // contoh: "LinkAja" / "Gopay"
  final String phoneNumber; // nomor tujuan
  final int nominal; // nominal isi ulang
  final int biayaAdmin; // biaya admin
  final int total; // total pembayaran (nominal + admin)

  const PinEWalletPage({
    super.key,
    required this.ewalletName,
    required this.phoneNumber,
    required this.nominal,
    required this.biayaAdmin,
    required this.total,
  });

  @override
  State<PinEWalletPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinEWalletPage> {
  String _pin = "";
  bool _isLoading = false;

  String _generateNoRef() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return "REF$ts";
  }

  Future<bool> _verifyPinWithBackend(String pin) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token");
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Token tidak ditemukan, silakan login ulang")),
        );
        return false;
      }

      final base = ApiService.baseUrl.replaceAll(RegExp(r'/+$'), '');
      final uri = Uri.parse("$base/auth/verify-pin");

      final resp = await http.post(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"pin": pin}),
      );

      debugPrint("🔑 Request ke: $uri");
      debugPrint("📤 Body: ${jsonEncode({"pin": pin})}");
      debugPrint("📥 StatusCode: ${resp.statusCode}");
      debugPrint("📥 Response: ${resp.body}");

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);

        // tangani berbagai kemungkinan format response
        if (data["success"] == true || data["status"] == true) {
          return true;
        } else {
          final msg = data["message"] ?? "PIN salah";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
          return false;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${resp.statusCode}")),
        );
        return false;
      }
    } catch (e) {
      debugPrint("❌ Error verifikasi PIN: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
      return false;
    }
  }

  void _onKeyboardTap(String value) async {
    if (value == "back") {
      if (_pin.isNotEmpty) {
        setState(() => _pin = _pin.substring(0, _pin.length - 1));
      }
    } else if (value == "ok") {
      if (_pin.length == 6) {
        setState(() => _isLoading = true);
        final isValid = await _verifyPinWithBackend(_pin);
        setState(() => _isLoading = false);

        if (isValid) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => StrukEWalletPage(
                ewalletName: widget.ewalletName,
                total: widget.total,
                noRef: _generateNoRef(),
                sumberDana: "Saldo PPOB",
                jenisTransaksi: "Top Up ${widget.ewalletName}",
                nama: "—",
                nomorTujuan: widget.phoneNumber,
                harga: widget.nominal,
                biayaAdmin: widget.biayaAdmin,
                tanggal: DateTime.now(),
              ),
            ),
          );
        } else {
          setState(() => _pin = "");
        }
      }
    } else {
      if (_pin.length < 6) {
        setState(() => _pin += value);
      }
    }
  }

  Widget _buildKeypadContent(String val) {
    if (val == "ok") {
      return _isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Container(
              width: 50.w,
              height: 50.w,
              decoration: const BoxDecoration(
                color: Color(0xFF5938FB),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white),
            );
    } else if (val == "back") {
      return const Icon(Icons.backspace_outlined,
          size: 28, color: Colors.black);
    } else {
      return Text(
        val,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 25,
          color: Colors.black,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: Column(
        children: [
          // 🔹 Bagian atas (ungu)
          Container(
            color: const Color(0xFF5938FB),
            child: Column(
              children: [
                SizedBox(
                  height: 135.h,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 120.h,
                        child: Image.asset(
                          'assets/images/header.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(16.r),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back,
                                size: 28.r, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                const Text(
                  "Masukkan PIN Anda",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30.h),

                // 🔹 PIN boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    final filled = index < _pin.length;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      width: 40.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: filled
                            ? const Icon(Icons.circle,
                                size: 12, color: Colors.black)
                            : const SizedBox(),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 150.h),
              ],
            ),
          ),

          // 🔹 Bagian bawah (putih) → keypad
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var row in [
                    ["1", "2", "3"],
                    ["4", "5", "6"],
                    ["7", "8", "9"],
                    ["back", "0", "ok"]
                  ])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: row.map((val) {
                        return Padding(
                          padding: EdgeInsets.all(8.r),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () => _onKeyboardTap(val),
                            child: Container(
                              width: 60.w,
                              height: 60.w,
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: _buildKeypadContent(val),
                            ),
                          ),
                        );
                      }).toList(),
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