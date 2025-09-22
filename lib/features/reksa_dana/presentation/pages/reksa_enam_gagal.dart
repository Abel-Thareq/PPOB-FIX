import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:ppob_app/features/main_screen/main_screen.dart'; // Import MainScreen
import 'reksa_tiga.dart'; // Import ReksaTigaPage

class ReksaEnamGagal extends StatefulWidget {
  final String productName;
  final String productImage;
  final int nominal;
  final double perkiraanUnit;

  const ReksaEnamGagal({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.nominal,
    required this.perkiraanUnit,
  }) : super(key: key);

  @override
  State<ReksaEnamGagal> createState() => _ReksaEnamGagalState();
}

class _ReksaEnamGagalState extends State<ReksaEnamGagal> {
  // Format Rupiah dengan titik
  String _formatRupiah(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  String _generateRandomString(int length) {
    final random = Random();
    const chars = "0123456789";
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _tryAgain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReksaTigaPage(), // Ganti dengan halaman ReksaTigaPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final horizontalPadding = 24.w;

    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy').format(now);
    final formattedTime = DateFormat('HH:mm:ss').format(now) + ' WIB';
    const sumberDanaNama = "ABEL THARIQ";
    const sumberDanaNomor = "06/25/5633863";
    const namaInvestor = "Kurnadi";

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
            // Header tetap di atas
            Container(
              height: 100.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
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
            ),
            // Konten yang bisa di-scroll di bawah header
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h, left: horizontalPadding, right: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Failure Icon
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 35.r,
                      ),
                    ),
                    SizedBox(height: 13.h),
                    // Failure Text
                    Text(
                      "Transaksi Gagal",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    // Transaction Details Container
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6.r,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DetailRow("Tanggal", "$formattedDate  $formattedTime"),
                          _DetailRow("No. Ref", "-"),
                          SizedBox(height: 16.h),
                          Divider(height: 1, color: Colors.grey.shade300),
                          SizedBox(height: 16.h),
                          _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                          _DetailRow("Jenis Transaksi", "Pembelian Reksa Dana"),
                          _DetailRow("Jenis Reksa Dana", widget.productName),
                          _DetailRow("Nama Investor", namaInvestor),
                          SizedBox(height: 16.h),
                          Divider(height: 1, color: Colors.grey.shade300),
                          SizedBox(height: 16.h),
                          Text(
                            "Lihat Detail Transaksi",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _DetailRow("Harga", _formatRupiah(widget.nominal)),
                          _DetailRow("Biaya Admin", "Rp0"),
                          SizedBox(height: 16.h),
                          Divider(height: 1, color: Colors.grey.shade300),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Pembelian",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                _formatRupiah(widget.nominal),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6A1B9A),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Perkiraan Unit",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                widget.perkiraanUnit.toStringAsFixed(4),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6A1B9A),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _onBackPressed,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Kembali',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _tryAgain,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Coba Lagi',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String? value2;

  const _DetailRow(this.label, this.value, {this.value2});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                if (value2 != null)
                  Text(
                    value2!,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}