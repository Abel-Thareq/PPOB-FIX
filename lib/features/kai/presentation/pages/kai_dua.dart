import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/kai/presentation/pages/kai_page.dart';
import 'package:ppob_app/features/kai/presentation/pages/kai_tiga.dart';

class KaiDuaPage extends StatefulWidget {
  const KaiDuaPage({super.key});

  @override
  State<KaiDuaPage> createState() => _KaiDuaPageState();
}

class _KaiDuaPageState extends State<KaiDuaPage> {
  final TextEditingController _kodeBayarController = TextEditingController();
  bool _isButtonEnabled = false;

  // Fungsi navigasi yang akan digunakan oleh tombol kembali
  void navigateToKai(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const KaiPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _kodeBayarController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _kodeBayarController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final bool isKodeBayarFilled = _kodeBayarController.text.isNotEmpty;
    setState(() {
      _isButtonEnabled = isKodeBayarFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double headerHeight = 100.h;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          navigateToKai(context);
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
                      "Bayar Tiket KAI",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Kode Bayar",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5938FB),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    _CustomTextField(
                      controller: _kodeBayarController,
                      hintText: "Masukkan Nomor KAI",
                      imagePath: "assets/images/kaiicon.png", // Diubah dari icon ke imagePath
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
              top: 40.h,
              left: 15.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28.r,
                onPressed: () {
                  navigateToKai(context);
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
                  builder: (context) => KaiTigaPage(
                    kodeBayar: _kodeBayarController.text,
                  ),
                ),
              );
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isButtonEnabled
                  ? const Color(0xFF5938FB)
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
  final String imagePath; // Diubah dari IconData ke String untuk path gambar

  const _CustomTextField({
    required this.controller,
    required this.hintText,
    required this.imagePath, // Parameter diubah
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
          // Mengganti Icon dengan Image.asset
          Image.asset(
            imagePath,
            width: 24.w, // Sesuaikan ukuran sesuai kebutuhan
            height: 24.h,
            color: Colors.grey[400], // Opsional: jika ingin memberi warna
          ),
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