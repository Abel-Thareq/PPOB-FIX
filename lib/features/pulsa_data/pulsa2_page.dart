import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/pulsa_data/pulsa3_page.dart';

class Pulsa2Page extends StatefulWidget {
  const Pulsa2Page({super.key});

  @override
  State<Pulsa2Page> createState() => _Pulsa2PageState();
}

class _Pulsa2PageState extends State<Pulsa2Page> {
  final TextEditingController _controller = TextEditingController();

  void _onKeyTap(String value) {
    setState(() {
      _controller.text += value;
    });
  }

  void _onDelete() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
      });
    }
  }

  void _onOk() {
    if (_controller.text.isEmpty || _controller.text.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nomor minimal 11 digit")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Pulsa3Page(
          phoneNumber: _controller.text, // kirim nomor ke Pulsa3Page
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: Column(
        children: [
          // 🔹 Header
          SizedBox(
            height: 140.h,
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
                          size: 28.r, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 24.w,
                  right: 24.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6.r,
                          offset: Offset(0, 3.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Pulsa & Paket Data',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Input Nomor HP
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nomor Handphone",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: _controller,
                  readOnly: true, // supaya input cuma dari keypad
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Image.asset("assets/images/phone.png",
                          width: 20.w, height: 20.h),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Image.asset("assets/images/contact.png",
                          width: 20.w, height: 20.h),
                    ),
                    hintText: "Masukan Nomor Handphone",
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                          color: const Color(0xFF5938FB), width: 1.2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.none,
                ),
              ],
            ),
          ),

          // 🔹 Keypad
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 222.h),
              color: const Color(0xFFF3F3F3),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildKeypadRow([
                    {"num": "1", "letters": ""},
                    {"num": "2", "letters": "ABC"},
                    {"num": "3", "letters": "DEF"}
                  ]),
                  _buildKeypadRow([
                    {"num": "4", "letters": "GHI"},
                    {"num": "5", "letters": "JKL"},
                    {"num": "6", "letters": "MNO"}
                  ]),
                  _buildKeypadRow([
                    {"num": "7", "letters": "PQRS"},
                    {"num": "8", "letters": "TUV"},
                    {"num": "9", "letters": "WXYZ"}
                  ]),

                  // 🔹 Baris terakhir: ⌫ – 0 – OK
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSpecialButton("⌫", onTap: _onDelete),
                        _buildKeyButton("0", ""),
                        _buildSpecialButton("OK", onTap: _onOk),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Tambahan: builder untuk satu baris keypad (1–3, 4–6, 7–9)
  Widget _buildKeypadRow(List<Map<String, String>> keys) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys
            .map((key) => _buildKeyButton(key["num"]!, key["letters"]!))
            .toList(),
      ),
    );
  }

  // 🔹 Tombol angka biasa
  Widget _buildKeyButton(String num, String letters) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: () => _onKeyTap(num),
      child: Container(
        width: 111.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              num,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            if (letters.isNotEmpty)
              Text(
                letters,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black54,
                  letterSpacing: 1,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 🔹 Tombol khusus (⌫, OK)
  Widget _buildSpecialButton(String label, {required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: onTap,
      child: Container(
        width: 111.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: label == "OK" ? const Color(0xFF5938FB) : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}