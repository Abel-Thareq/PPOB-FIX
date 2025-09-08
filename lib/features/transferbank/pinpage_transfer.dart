import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'struk_transfer_page.dart';

// 🔹 Helper getBankLogo (konsisten, walau tidak dipakai langsung di sini)
String getBankLogo(String bankName) {
  switch (bankName) {
    case "Bank BRI":
      return "assets/images/bank_bri.png";
    case "Bank Mandiri":
      return "assets/images/bank_mandiri.png";
    case "Bank BNI":
      return "assets/images/bank_bni.png";
    case "Bank BCA":
      return "assets/images/bank_bca.png";
    case "Bank BSI":
      return "assets/images/bank_bsi.png";
    case "Bank BTN":
      return "assets/images/bank_btn.png";
    case "Bank CIMB NIAGA":
      return "assets/images/bank_cimb.png";
    case "Bank DANAMON":
      return "assets/images/bank_danamon.png";
    case "Bank PERMATA":
      return "assets/images/bank_permata.png";
    case "Bank PANIN":
      return "assets/images/bank_panin.png";
    default:
      return "assets/images/default_bank.png";
  }
}

class PinTransferPage extends StatefulWidget {
  final String bankName;
  final String rekeningNumber;
  final String namaPenerima;
  final int nominal;
  final int biayaAdmin;
  final int total;
  final String catatan;

  const PinTransferPage({
    super.key,
    required this.bankName,
    required this.rekeningNumber,
    required this.namaPenerima,
    required this.nominal,
    required this.biayaAdmin,
    required this.total,
    required this.catatan,
  });

  @override
  State<PinTransferPage> createState() => _PinTransferPageState();
}

class _PinTransferPageState extends State<PinTransferPage> {
  String _pin = "";

  /// 🔹 Generate Nomor Referensi Unik
  String _generateNoRef() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return "REF$ts";
  }

  /// 🔹 Event ketika keypad ditekan
  void _onKeyboardTap(String value) {
    if (value == "back") {
      if (_pin.isNotEmpty) {
        setState(() => _pin = _pin.substring(0, _pin.length - 1));
      }
    } else if (value == "ok") {
      if (_pin.length == 6) {
        if (_pin == "123456") {
          // ✅ Jika PIN benar → langsung ke StrukTransferPage
          final noRef = _generateNoRef();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => StrukTransferPage(
                noRef: noRef,
                bankName: widget.bankName,
                rekeningNumber: widget.rekeningNumber,
                namaPenerima: widget.namaPenerima,
                nominal: widget.nominal,
                biayaAdmin: widget.biayaAdmin,
                total: widget.total,
                catatan: widget.catatan,
                tanggal: DateTime.now(),
              ),
            ),
          );
        } else {
          // ❌ PIN salah
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("PIN salah, coba lagi")),
          );
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
      return Container(
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
          // 🔹 Header
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

                // 🔹 PIN Boxes
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

          // 🔹 Keypad
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