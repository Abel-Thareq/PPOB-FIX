import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DonasiEnamBerhasil extends StatefulWidget {
  final String institutionName;
  final String institutionImage;
  final int nominal;
  final int adminFee;

  const DonasiEnamBerhasil({
    super.key,
    required this.institutionName,
    required this.institutionImage,
    required this.nominal,
    required this.adminFee,
  });

  @override
  State<DonasiEnamBerhasil> createState() => _DonasiEnamBerhasilState();
}

class _DonasiEnamBerhasilState extends State<DonasiEnamBerhasil> {
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
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _shareTransactionDetails() {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy').format(now);
    final formattedTime = DateFormat('HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);
    const sumberDanaNama = "ABEL THAREO";
    const sumberDanaNomor = "081215633163";
    final totalPembelian = _formatRupiah(widget.nominal + widget.adminFee);

    final details = """
Transaksi Berhasil!

Detail Transaksi:
----------------------------------------
Tanggal: $formattedDate
Waktu: $formattedTime
No. Ref: $noRef
Sumber Dana: $sumberDanaNama ($sumberDanaNomor)
Jenis Transaksi: Donasi
Lembaga/Yayasan: ${widget.institutionName}
Nominal: ${_formatRupiah(widget.nominal)}
Biaya Admin: ${_formatRupiah(widget.adminFee)}
Total Pembelian: $totalPembelian
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
    const sumberDanaNomor = "081215633163";
    final totalPembelian = widget.nominal + widget.adminFee;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
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
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 120.h, bottom: 20.h, left: horizontalPadding, right: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        _DetailRow("Tanggal", formattedDate, value2: formattedTime),
                        _DetailRow("No. Ref", noRef),
                        SizedBox(height: 16.h),
                        Divider(height: 1, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                        _DetailRow("Jenis Transaksi", "Donasi"),
                        _DetailRow("Lembaga/Yayasan", widget.institutionName),
                        SizedBox(height: 16.h),
                        Divider(height: 1, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        _DetailRow("Nominal", _formatRupiah(widget.nominal)),
                        _DetailRow("Biaya Admin", _formatRupiah(widget.adminFee)),
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
                              _formatRupiah(totalPembelian),
                              style: TextStyle(
                                fontSize: 14.sp,
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
                            'Selesai',
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