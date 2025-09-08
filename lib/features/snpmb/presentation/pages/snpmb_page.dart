import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/snpmb/presentation/pages/snpmb_dua.dart';

class SnpmbPage extends StatefulWidget {
  const SnpmbPage({super.key});

  @override
  State<SnpmbPage> createState() => _SnpmbPageState();
}

class _SnpmbPageState extends State<SnpmbPage> {
  final TextEditingController _kodePembayaranController = TextEditingController();
  final TextEditingController _nisnController = TextEditingController();
  bool _isButtonEnabled = false;
  
  // Fungsi navigasi yang akan digunakan oleh tombol kembali
  void navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _kodePembayaranController.addListener(_updateButtonState);
    _nisnController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _kodePembayaranController.dispose();
    _nisnController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final bool isKodeFilled = _kodePembayaranController.text.isNotEmpty;
    final bool isNisnFilled = _nisnController.text.isNotEmpty;
    setState(() {
      _isButtonEnabled = isKodeFilled && isNisnFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double headerHeight = 120.h;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          navigateToMainScreen(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            // Konten halaman utama yang bisa digulir
            Padding(
              padding: EdgeInsets.only(top: headerHeight),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "Bayar SNMPB",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Kode Pembayaran",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6A1B9A),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _CustomTextField(
                      controller: _kodePembayaranController,
                      hintText: "Masukkan Kode Pembayaran",
                      icon: Icons.assignment,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "NISN",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6A1B9A),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _CustomTextField(
                      controller: _nisnController,
                      hintText: "Masukkan NISN",
                      icon: Icons.credit_card,
                    ),
                    // Memberikan ruang di bagian bawah
                    SizedBox(height: 40.h), 
                  ],
                ),
              ),
            ),
            // Header
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            // Tombol kembali
            Positioned(
              top: 50.h,
              left: 10.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28.r,
                onPressed: () {
                  navigateToMainScreen(context);
                },
              ),
            ),
          ],
        ),
        // Tombol "Lanjutkan" yang diposisikan di bawah menggunakan bottomNavigationBar
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(24.w),
          child: ElevatedButton(
            onPressed: _isButtonEnabled ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SnpmbDuaPage(
                    kodePembayaran: _kodePembayaranController.text,
                    nisn: _nisnController.text,
                  ),
                ),
              );
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isButtonEnabled
                  ? const Color(0xFF6A1B9A)
                  : const Color(0xFFE0E0E0),
              foregroundColor: _isButtonEnabled
                  ? Colors.white
                  : Colors.grey[600],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              elevation: 0,
            ),
            child: Text(
              "Lanjutkan",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  const _CustomTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400]),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
