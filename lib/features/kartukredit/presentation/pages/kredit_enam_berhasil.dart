import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'dart:math';

class KreditEnamBerhasil extends StatefulWidget {
  final String nominalTagihan;
  final String biayaAdmin;
  final String nominalPembayaran;
  final String namaPelanggan;
  final String nomorKartu;
  final String namaBank;
  final String jatuhTempo;

  const KreditEnamBerhasil({
    super.key,
    required this.nominalTagihan,
    required this.biayaAdmin,
    required this.nominalPembayaran,
    required this.namaPelanggan,
    required this.nomorKartu,
    required this.namaBank,
    required this.jatuhTempo,
  });

  @override
  State<KreditEnamBerhasil> createState() => _KreditEnamBerhasilState();
}

class _KreditEnamBerhasilState extends State<KreditEnamBerhasil> {
  String formatCurrency(String amount) {
    try {
      if (amount.isEmpty) return 'Rp0';
      final int parsedAmount = int.tryParse(amount.replaceAll('.', '').replaceAll('Rp', '').replaceAll(',', '').trim()) ?? 0;
      return NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      ).format(parsedAmount);
    } catch (e) {
      return 'Rp0';
    }
  }

  String getValue(String value, {String defaultValue = '-'}) {
    if (value.isEmpty) return defaultValue;
    return value;
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
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);

    final details = """
Transaksi Berhasil!

Detail Pembayaran Kartu Kredit:
----------------------------------------
Tanggal: $formattedDate
No. Ref: $noRef
Sumber Dana: ${widget.namaPelanggan}
Jenis Transaksi: Bayar Kartu Kredit
Nama Kartu: ${widget.namaPelanggan}
Nomor Kartu: ${widget.nomorKartu}
Nama Bank: ${widget.namaBank}
Jatuh Tempo: ${widget.jatuhTempo}
Harga: ${formatCurrency(widget.nominalTagihan)}
Biaya Admin: ${formatCurrency(widget.biayaAdmin)}
Total Pembelian: ${formatCurrency(widget.nominalPembayaran)}
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
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);

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
                        _DetailRow("Tanggal", formattedDate),
                        _DetailRow("No. Ref", noRef),
                        SizedBox(height: 16.h),
                        Divider(height: 1, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        _DetailRow("Sumber Dana", widget.namaPelanggan),
                        _DetailRow("Jenis Transaksi", "Bayar Kartu Kredit"),
                        _DetailRow("Nama Kartu", widget.namaPelanggan),
                        _DetailRow("Nomor Kartu", widget.nomorKartu),
                        _DetailRow("Nama Bank", widget.namaBank),
                        SizedBox(height: 16.h),
                        Divider(height: 1, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        _DetailRow("Harga", formatCurrency(widget.nominalTagihan)),
                        _DetailRow("Biaya Admin", formatCurrency(widget.biayaAdmin)),
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
                              formatCurrency(widget.nominalPembayaran),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6C4EFF),
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
                            foregroundColor: const Color(0xFF6C4EFF),
                            side: const BorderSide(color: Color(0xFF6C4EFF)),
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
                            backgroundColor: const Color(0xFF6C4EFF),
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

  const _DetailRow(this.label, this.value);

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
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}