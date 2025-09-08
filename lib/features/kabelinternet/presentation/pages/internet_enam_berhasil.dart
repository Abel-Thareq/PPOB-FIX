import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'dart:math';

class InternetEnamBerhasil extends StatefulWidget {
  final String selectedService;
  final String customerNumber;
  final Map<String, dynamic> selectedPackage;

  const InternetEnamBerhasil({
    super.key,
    required this.selectedService,
    required this.customerNumber,
    required this.selectedPackage,
  });

  @override
  State<InternetEnamBerhasil> createState() => _InternetEnamBerhasilState();
}

class _InternetEnamBerhasilState extends State<InternetEnamBerhasil> {
  String formatCurrency(dynamic amount) {
    try {
      if (amount == null) return 'Rp0';
      final String amountStr = amount.toString();
      final int parsedAmount = int.tryParse(amountStr.replaceAll('.', '').replaceAll('Rp', '').trim()) ?? 0;
      return NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      ).format(parsedAmount);
    } catch (e) {
      return 'Rp0';
    }
  }

  // Fungsi untuk menghitung total pembelian (harga + biaya admin)
  String _calculateTotal(Map<String, dynamic> package) {
    final nominal = int.parse(package['details']['nominal'].replaceAll('Rp', '').replaceAll('.', '').replaceAll(',', ''));
    final biayaAdmin = int.parse(package['details']['biayaAdmin'].replaceAll('Rp', '').replaceAll('.', '').replaceAll(',', ''));
    final total = nominal + biayaAdmin;
    
    return 'Rp${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  String getValue(dynamic value, {String defaultValue = '-'}) {
    if (value == null) return defaultValue;
    return value.toString();
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
    const sumberDanaNama = "ABEL THAREO";
    const sumberDanaNomor = "081390147404";
    final totalPembelian = _calculateTotal(widget.selectedPackage); // Menggunakan fungsi perhitungan

    final details = """
Transaksi Berhasil!

Detail Transaksi:
----------------------------------------
Tanggal: $formattedDate
No. Ref: $noRef
Sumber Dana: $sumberDanaNama ($sumberDanaNomor)
Jenis Transaksi: TV Kabel & Internet
Nomor Tujuan: ${widget.customerNumber}
Paket: ${getValue(widget.selectedPackage['title'])}
Harga: ${formatCurrency(widget.selectedPackage['details']['nominal'])}
Biaya Admin: ${formatCurrency(widget.selectedPackage['details']['biayaAdmin'])}
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
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);
    const sumberDanaNama = "ABEL THAREO";
    const sumberDanaNomor = "081390147404";
    final totalPembelian = _calculateTotal(widget.selectedPackage); // Menggunakan fungsi perhitungan

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
                        _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                        _DetailRow("Jenis Transaksi", "TV Kabel & Internet"),
                        _DetailRow("Nomor Tujuan", widget.customerNumber),
                        SizedBox(height: 16.h),
                        Divider(height: 1, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        _DetailRow("Harga", formatCurrency(widget.selectedPackage['details']['nominal'])),
                        _DetailRow("Biaya Admin", formatCurrency(widget.selectedPackage['details']['biayaAdmin'])),
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
                              totalPembelian, // Menggunakan hasil perhitungan
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