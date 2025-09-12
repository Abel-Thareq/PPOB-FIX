import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/pajak%20daerah/presentation/pages/pajakdaerah_page.dart';

class PajakDaerahGagal extends StatefulWidget {
  final String provinceName;
  final String provinceImage;
  final String cityName;
  final String tagihanNumber;

  const PajakDaerahGagal({
    super.key,
    required this.provinceName,
    required this.provinceImage,
    required this.cityName,
    required this.tagihanNumber,
  });

  @override
  State<PajakDaerahGagal> createState() => _PajakDaerahGagalState();
}

class _PajakDaerahGagalState extends State<PajakDaerahGagal> {
  // Format angka ke Rupiah
  String formatCurrency(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  // Generate string acak untuk no referensi
  String _generateRandomString(int length) {
    final random = Random();
    const chars = "0123456789abcdef";
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // Kembali ke halaman utama
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Coba lagi → balik ke input Pajak
  void _onTryAgainPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const PajakDaerahPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);
    final totalTagihan = 500000;

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
            // Header background
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/header.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Konten utama
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 140.h, bottom: 20.h, left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon gagal
                  Container(
                    width: 60.w,
                    height: 60.h,
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
                  Text(
                    "Transaksi Gagal",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // Box detail transaksi
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
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),

                        _DetailRow("Sumber Dana", "ABEL THAREQ"),
                        _DetailRow("", "082E683863"),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),

                        _DetailRow("Jenis Transaksi", "Bayar Pajak Daerah"),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),

                        _DetailRow("Nomor Tagihan", widget.tagihanNumber),
                        _DetailRow("Nama Wajib Bayar", "ALFIN CHIPMUNK"),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              // TODO: detail transaksi gagal
                            },
                            child: Text(
                              "Lihat Detail Transaksi",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6A1B9A),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),

                        _DetailRow("Harga", formatCurrency(totalTagihan)),
                        _DetailRow("Denda", formatCurrency(0)),
                        _DetailRow("Biaya Admin", formatCurrency(0)),
                        SizedBox(height: 12.h),
                        Divider(height: 1.h, color: Colors.grey.shade300),
                        SizedBox(height: 12.h),

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
                              formatCurrency(totalTagihan),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Tombol aksi
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _onBackPressed,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6A1B9A),
                            side: const BorderSide(color: Color(0xFF6A1B9A)),
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
                          onPressed: _onTryAgainPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6A1B9A),
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

            // Tombol back atas
            Positioned(
              top: 43.h,
              left: 19.w,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 28.r,
                  padding: EdgeInsets.all(12.r),
                  onPressed: _onBackPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget row detail
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
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
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
