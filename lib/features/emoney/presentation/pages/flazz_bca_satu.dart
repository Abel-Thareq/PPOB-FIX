import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/emoney/presentation/pages/flazz_bca_dua.dart';
import 'dart:async';
import 'package:ppob_app/features/home/presentation/pages/emoney_page.dart'; // Import EMoneyPage

// Mengubah dari StatelessWidget menjadi StatefulWidget untuk mengelola PopScope
class FlazzBcaSatuPage extends StatefulWidget {
  const FlazzBcaSatuPage({super.key});

  @override
  State<FlazzBcaSatuPage> createState() => _FlazzBcaSatuPageState();
}

class _FlazzBcaSatuPageState extends State<FlazzBcaSatuPage> {
  // Controller untuk TextField
  final TextEditingController _cardController = TextEditingController();

  // Fungsi untuk menangani navigasi kembali ke EMoneyPage
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const EMoneyPage()),
          (Route<dynamic> route) => false,
    );
  }

  // Method untuk menampilkan bottom sheet proses memindai
  void _showScanningProcessBottomSheet(BuildContext context, String cardNumber) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext bc) {
        return _ScanningProcessBottomSheetContent(cardNumber: cardNumber);
      },
    );
  }

  // Method untuk menampilkan bottom sheet info kartu secara langsung
  void _showInfoCardBottomSheet(BuildContext context, String cardNumber) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext bc) {
        return _InfoCardBottomSheetContent(cardNumber: cardNumber);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Listener untuk mendeteksi perubahan teks pada TextField
    _cardController.addListener(() {
      if (_cardController.text.length == 12) {
        _showInfoCardBottomSheet(context, _cardController.text);
      }
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ScreenUtil untuk desain responsif
    ScreenUtil.init(context, designSize: const Size(360, 690));

    // PopScope akan menangani tombol kembali fisik dan menonaktifkan perilaku default
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 140.h,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120.h,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/header.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 28.r),
                        color: Colors.white,
                        onPressed: _onBackPressed, // Memanggil fungsi _onBackPressed
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.w,
                    left: 24.w,
                    right: 24.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
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
                          'FLAZZ BCA',
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
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Top Up Flazz',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cardController,
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Nomor FLAZZ',
                        counterText: '',
                        prefixIcon: const Icon(Icons.credit_card_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () {
                      _showScanningProcessBottomSheet(context, _cardController.text);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5938FB),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          'Scan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk bottom sheet proses memindai dan berubah
class _ScanningProcessBottomSheetContent extends StatefulWidget {
  final String cardNumber;
  const _ScanningProcessBottomSheetContent({required this.cardNumber});

  @override
  _ScanningProcessBottomSheetContentState createState() => _ScanningProcessBottomSheetContentState();
}

class _ScanningProcessBottomSheetContentState extends State<_ScanningProcessBottomSheetContent> {
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    // Atur timer 5 detik untuk mengubah state dari "memindai" ke "info kartu"
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: _isScanning ? _buildScanningView(context) : _buildInfoView(context, widget.cardNumber),
    );
  }
}

// Widget untuk bottom sheet info kartu saja
class _InfoCardBottomSheetContent extends StatelessWidget {
  final String cardNumber;
  const _InfoCardBottomSheetContent({required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: _buildInfoView(context, cardNumber),
    );
  }
}

// Helper method untuk tampilan memindai
Widget _buildScanningView(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Siap Memindai',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 20.h),
      Image.asset(
        'assets/images/scan.png',
        width: 135.w,
        height: 135.w,
      ),
      SizedBox(height: 20.h),
      Text(
        'Sedang membaca kartu...\nJangan mengubah posisi kartu.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[600],
        ),
      ),
      SizedBox(height: 30.h),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF0F0F0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          minimumSize: Size(double.infinity, 48.h),
        ),
        child: Text(
          'Batalkan',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}

// Helper method untuk tampilan info kartu
Widget _buildInfoView(BuildContext context, String cardNumber) {
  // Memformat nomor kartu menjadi 4 digit per blok
  final formattedCardNumber = cardNumber.replaceAllMapped(
    RegExp(r".{4}"),
        (match) => "${match.group(0)} ",
  ).trim();

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Info Kartu',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, size: 24.r, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      SizedBox(height: 9.h),
      Image.asset(
        'assets/images/flazz.png',
        height: 50.h,
      ),
      SizedBox(height: 10.h),
      Text(
        formattedCardNumber,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 20.h),
      Text(
        'Saldo Saat Ini',
        style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
      ),
      SizedBox(height: 4.h),
      Text(
        'Rp23.000',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF5938FB),
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        'Terakhir di-update 14 Agustus 2025, 16:00',
        style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
      ),
      SizedBox(height: 30.h),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Menutup bottom sheet
          // Meneruskan nomor kartu ke halaman berikutnya
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlazzBcaDuaPage(cardNumber: cardNumber),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5938FB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          minimumSize: Size(double.infinity, 48.h),
        ),
        child: Text(
          'Top Up',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
