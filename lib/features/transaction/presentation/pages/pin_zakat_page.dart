import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ppob_app/features/transaction/presentation/pages/struk_zakatberhasil_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/struk_zakatgagal_page.dart';
// Ganti dengan halaman struk berhasil atau gagal Anda
// import 'struk_zakat_berhasil_page.dart';
// import 'struk_zakat_gagal_page.dart';

class PinZakatPage extends StatefulWidget {
  final Map<String, dynamic> transactionData;

  const PinZakatPage({super.key, required this.transactionData});

  @override
  State<PinZakatPage> createState() => _PinZakatPageState();
}

class _PinZakatPageState extends State<PinZakatPage> {
  String _pin = "";
  final int _pinLength = 6;

  String _generateNoRef() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return "REF$ts";
  }

  void _onKeyboardTap(String value) {
    if (value == "back") {
      if (_pin.isNotEmpty) {
        setState(() => _pin = _pin.substring(0, _pin.length - 1));
      }
    } else if (value == "ok" && _pin.length == _pinLength) {
      // Logika verifikasi PIN. Ganti "123456" dengan PIN yang valid.
      if (_pin == "123456") {
        // Navigasi ke halaman struk berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StrukZakatBerhasilPage(
              noRef: _generateNoRef(),
              transactionData: {
                ...widget.transactionData,
                'nominal': widget.transactionData['nominal']?.toString().trim(),
              },
              tanggal: DateTime.now(),
            ),
          ),
        );
      } else {
        // Navigasi ke halaman struk gagal
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(
             builder: (_) => StrukZakatGagalPage(
               noRef: _generateNoRef(),
               transactionData: widget.transactionData,
               tanggal: DateTime.now(),
             ),
           ),
        );
      }
    } else if (value != "ok" && _pin.length < _pinLength) {
      setState(() => _pin += value);
    }
  }

  Widget _buildPinBox(int index) {
    final bool filled = index < _pin.length;
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
            ? const Icon(Icons.circle, size: 12, color: Colors.black)
            : const SizedBox(),
      ),
    );
  }

  Widget _buildKeypadContent(String val) {
    if (val == "ok") {
      return Container(
        width: 50.w,
        height: 50.w,
        decoration: const BoxDecoration(
          color: Color(0xFF6C4DF4),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white),
      );
    } else if (val == "back") {
      return const Icon(
        Icons.backspace_outlined,
        size: 28,
        color: Colors.black,
      );
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
    // Pastikan ScreenUtil diinisialisasi di sini atau di atasnya.
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Column(
        children: [
          Container(
            height: 320.h,
            width: double.infinity,
            color: const Color(0xFF6C4DF4),
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: SvgPicture.asset(
                    'assets/images/backgroundtop.svg',
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
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: const [
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
                Positioned(
                  top: 150.h,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      const Text(
                        "Masukkan PIN Anda",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                          (index) => _buildPinBox(index),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFF8F8FF),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var row in [
                    ["1", "2", "3"],
                    ["4", "5", "6"],
                    ["7", "8", "9"],
                    ["back", "0", "ok"],
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
