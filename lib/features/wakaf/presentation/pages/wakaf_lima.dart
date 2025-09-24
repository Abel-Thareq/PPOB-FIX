import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'wakaf_model.dart';
import 'wakaf_enam.dart'; // Import halaman PIN

class WakafLimaPage extends StatelessWidget {
  final WakafModel wakaf;
  final int selectedAmount;
  final String selectedLabel;

  const WakafLimaPage({
    super.key,
    required this.wakaf,
    required this.selectedAmount,
    required this.selectedLabel,
  });

  // Format Rupiah dengan titik
  String _formatRupiah(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    final double horizontalPadding = 24.w;
    final int adminFee = 0; // Biaya admin untuk wakaf biasanya 0
    final int totalAmount = selectedAmount + adminFee;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Bagian Header
          SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100.h,
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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Konten Halaman
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bagian "Sumber Dana"
                  Text(
                    'Sumber Dana',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6A1B9A),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF6A1B9A),
                      child: Text(
                        'AT',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                    title: Text(
                      'ABEL THAREO',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'modipay - 081215633163',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    ),
                  ),
                  Divider(height: 1.h, thickness: 1),
                  SizedBox(height: 16.h),

                  // Bagian "Tujuan"
                  Text(
                    'Tujuan',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6A1B9A),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.mosque,
                        color: Color(0xFF5938FB),
                        size: 20.r,
                      ),
                    ),
                    title: Text(
                      wakaf.title,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Wakaf',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 7.h),

                  // Bagian "Tambah Ke Daftar Tersimpan"
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tambah Ke Daftar Tersimpan',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Switch(
                          value: true,
                          onChanged: (bool value) {
                            // Implementasikan fungsionalitas switch di sini
                          },
                          activeColor: const Color(0xFF6A1B9A),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Divider(height: 1.h, thickness: 1),
                  SizedBox(height: 16.h),

                  // Bagian "Detail Donasi"
                  Text(
                    'Detail Donasi',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6A1B9A),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Menampilkan Nominal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nominal',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),
                      Text(
                        _formatRupiah(selectedAmount),
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Menampilkan Biaya Admin
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Biaya Admin',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),
                      Text(
                        _formatRupiah(adminFee),
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(height: 1.h, thickness: 1),
                  SizedBox(height: 16.h),

                  // Menampilkan Total (nominal + biaya admin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6A1B9A),
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
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),

          // Tombol Konfirmasi
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.h),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showPaymentConfirmation(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 0,
                ),
                child: Text(
                  'Konfirmasi',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Konfirmasi Pembayaran',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6A1B9A),
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Program: ${wakaf.title}',
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Nominal: ${_formatRupiah(selectedAmount)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5938FB),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Apakah Anda yakin ingin melanjutkan pembayaran?',
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Batal',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup dialog konfirmasi
                      // Navigasi ke halaman PIN (WakafEnamPage)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WakafEnamPage(
                            wakaf: wakaf,
                            selectedAmount: selectedAmount,
                            selectedLabel: selectedLabel,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6A1B9A),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Ya, Bayar',
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
        );
      },
    );
  }
}