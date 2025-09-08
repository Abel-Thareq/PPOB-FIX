import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:ppob_app/features/byu/presentation/pages/byu_dua.dart'; // Impor ByuDuaPage

// Halaman ini berfungsi untuk memasukkan kode pembayaran
class ByuSatu1Page extends StatefulWidget {
  const ByuSatu1Page({super.key});

  @override
  State<ByuSatu1Page> createState() => _ByuSatu1PageState();
}

class _ByuSatu1PageState extends State<ByuSatu1Page> {
  // Controller untuk mengelola teks di TextField.
  final TextEditingController _paymentCodeController = TextEditingController();
  // FocusNode untuk mengelola fokus input.
  final FocusNode _focusNode = FocusNode();

  // State untuk melacak apakah kode yang dimasukkan valid
  bool _isCodeValid = false;
  // State untuk menyimpan data promo yang valid
  Map<String, dynamic>? _selectedPromo;

  // Data kode pembayaran dan detail paketnya
  final Map<String, Map<String, dynamic>> _promoData = {
    'VBYUB9': {
      'title': 'Paket Roaming Korea Selatan 20 GB, 7 hari',
      'price': 'Rp3.615',
      'details': {
        'nominal': 'Rp2.500',
        'biayaAdmin': 'Rp1.115',
      }
    },
    'BYU7D5': {
      'title': 'Paket Kuota Weekend 5 GB, 7 hari',
      'price': 'Rp2.000',
      'details': {
        'nominal': 'Rp1.500',
        'biayaAdmin': 'Rp500',
      }
    },
    'BYULITE': {
      'title': 'Paket Lite 3 GB, 30 hari',
      'price': 'Rp1.500',
      'details': {
        'nominal': 'Rp1.000',
        'biayaAdmin': 'Rp500',
      }
    },
    // Abang bisa tambahkan kode lain di sini sesuai kebutuhan
  };

  @override
  void initState() {
    super.initState();
    // Menambahkan listener ke controller untuk memantau perubahan teks
    _paymentCodeController.addListener(_validatePaymentCode);
  }

  @override
  void dispose() {
    // Memastikan listener, controller, dan focus node dibuang saat widget dihapus.
    _paymentCodeController.removeListener(_validatePaymentCode);
    _paymentCodeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Fungsi untuk memvalidasi kode pembayaran
  void _validatePaymentCode() {
    final paymentCode = _paymentCodeController.text.toUpperCase().trim();
    // Memeriksa apakah kode yang dimasukkan ada di dalam data _promoData
    if (_promoData.containsKey(paymentCode)) {
      setState(() {
        _isCodeValid = true;
        _selectedPromo = _promoData[paymentCode];
      });
    } else {
      setState(() {
        _isCodeValid = false;
        _selectedPromo = null;
      });
    }
  }

  // Fungsi untuk menangani navigasi kembali ke halaman sebelumnya
  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  // Fungsi untuk menangani saat tombol Lanjutkan ditekan
  void _onContinuePressed() {
    // Memastikan data promo tersedia sebelum navigasi
    if (_selectedPromo != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ByuDuaPage(selectedPromo: _selectedPromo!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ScreenUtil untuk desain responsif.
    ScreenUtil.init(context, designSize: const Size(360, 690));

    // Menentukan warna tombol berdasarkan validasi
    final Color buttonColor = _isCodeValid ? const Color(0xFF5938FB) : Colors.grey.shade300;
    final Color textColor = _isCodeValid ? Colors.white : Colors.grey.shade600;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Column(
          children: [
            // Bagian Header dengan gambar dan tombol kembali
            Stack(
              children: [
                SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16.h,
                  left: 16.w,
                  child: SafeArea(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 28.r,
                      onPressed: _onBackPressed,
                    ),
                  ),
                ),
              ],
            ),
            // Konten utama yang dapat discroll
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kode Pembayaran',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Text field untuk kode pembayaran
                    TextField(
                      controller: _paymentCodeController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Kode Pembayaran',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade400,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF5938FB), // Warna border saat fokus
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
            // Tombol Lanjutkan di bagian bawah yang tetap
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // Tombol akan bisa ditekan jika _isCodeValid true, jika tidak maka null
                  onPressed: _isCodeValid ? _onContinuePressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    // Mengubah elevation menjadi 0 jika tombol tidak aktif
                    elevation: _isCodeValid ? 2 : 0,
                  ),
                  child: Text(
                    'Lanjutkan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor, // Menyesuaikan warna teks
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
