import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'struk_pulsa_page.dart';

class PinPulsaPage extends StatefulWidget {
  final String sumberDana;
  final String tujuan;
  final String nomorSerial;
  final int harga;
  final int biayaAdmin;
  final int total;

  const PinPulsaPage({
    super.key,
    required this.sumberDana,
    required this.tujuan,
    required this.nomorSerial,
    required this.harga,
    required this.biayaAdmin,
    required this.total,
  });

  @override
  State<PinPulsaPage> createState() => _PinPulsaPageState();
}

class _PinPulsaPageState extends State<PinPulsaPage> {
  String _pin = "";

  String _generateNoRef() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return "REF$ts";
  }

  void _onKeyboardTap(String value) {
    if (value == "back") {
      if (_pin.isNotEmpty) {
        setState(() => _pin = _pin.substring(0, _pin.length - 1));
      }
    } else if (value == "ok") {
      if (_pin.length == 6) {
        if (_pin == "123456") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => StrukPulsaPage(
                noRef: _generateNoRef(),
                sumberDana: widget.sumberDana,
                tujuan: widget.tujuan,
                nomorSerial: widget.nomorSerial,
                harga: widget.harga,
                biayaAdmin: widget.biayaAdmin,
                total: widget.total,
                tanggal: DateTime.now(),
              ),
            ),
          );
        } else {
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