import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'dart:math';

import 'wakaf_model.dart';

class WakafTujuhBerhasil extends StatefulWidget {
  final WakafModel wakaf;
  final int selectedAmount;
  final String selectedLabel;

  const WakafTujuhBerhasil({
    Key? key,
    required this.wakaf,
    required this.selectedAmount,
    required this.selectedLabel,
  }) : super(key: key);

  @override
  State<WakafTujuhBerhasil> createState() => _WakafTujuhBerhasilState();
}

class _WakafTujuhBerhasilState extends State<WakafTujuhBerhasil> {
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

  void _shareTransactionDetails() {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy').format(now);
    final formattedTime = DateFormat('HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);
    const sumberDanaNama = "ABEL THAREO";
    const sumberDanaNomor = "081390147404";

    final details = """
Transaksi Berhasil!

Detail Transaksi:
----------------------------------------
Tanggal: $formattedDate $formattedTime
No. Ref: $noRef
Sumber Dana: $sumberDanaNama ($sumberDanaNomor)
Jenis Transaksi: Bayar Wakaf
Program Wakaf: ${widget.wakaf.title}
Harga: ${_formatRupiah(widget.selectedAmount)}
Biaya Admin: Rp0
Total Pembelian: ${_formatRupiah(widget.selectedAmount)}
----------------------------------------
    """;

    Clipboard.setData(ClipboardData(text: details)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Detail Transaksi berhasil di copy"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final horizontalPadding = 24.w;

    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy').format(now);
    final formattedTime = DateFormat('HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);
    const sumberDanaNama = "ABEL THAREO";
    const sumberDanaNomor = "081390147404";
    final int adminFee = 0;
    final int totalAmount = widget.selectedAmount + adminFee;

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
            // Header tetap di atas - TIDAK BISA SCROLL
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
                padding: EdgeInsets.only(
                  top: 20.h, 
                  bottom: 20.h, 
                  left: horizontalPadding, 
                  right: horizontalPadding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Success Icon
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 35.r,
                      ),
                    ),
                    SizedBox(height: 13.h),
                    Text(
                      "Transaksi Berhasil",
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
                          // Tanggal dan No. Ref
                          _DetailRow("Tanggal", "$formattedDate\n$formattedTime"),
                          _DetailRow("No. Ref", noRef),
                          SizedBox(height: 16.h),
                          Divider(height: 1, color: Colors.grey.shade300),
                          SizedBox(height: 16.h),
                          
                          // Sumber Dana dan Jenis Transaksi
                          _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                          _DetailRow("Jenis Transaksi", "Bayar Wakaf", value2: widget.wakaf.title),
                          SizedBox(height: 16.h),
                          Divider(height: 1, color: Colors.grey.shade300),
                          SizedBox(height: 16.h),
                          
                          // Harga dan Biaya Admin
                          _DetailRow("Harga", _formatRupiah(widget.selectedAmount)),
                          _DetailRow("Biaya Admin", _formatRupiah(adminFee)),
                          SizedBox(height: 16.h),
                          Divider(height: 1, color: Colors.grey.shade300),
                          SizedBox(height: 16.h),
                          
                          // Total Pembelian
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Pembelian",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                _formatRupiah(totalAmount),
                                style: TextStyle(
                                  fontSize: 16.sp,
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
                    
                    // Action Buttons - TETAP TERLIHAT MESKI DI-SCROLL
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _shareTransactionDetails,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF6A1B9A),
                              side: const BorderSide(color: Color(0xFF6A1B9A)),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Bagikan',
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
                            onPressed: _onBackPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6A1B9A),
                              foregroundColor: Colors.white,
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
                      ],
                    ),
                    
                    // Tambahkan spacer untuk memastikan tombol tidak tertutup keyboard
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 0 ? 100.h : 20.h),
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