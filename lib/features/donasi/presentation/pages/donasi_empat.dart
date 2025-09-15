import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/donasi/presentation/pages/donasi_lima.dart';

class DonasiEmpatPage extends StatelessWidget {
  final String institutionName;
  final String institutionImage;
  final int nominal;
  final int adminFee;

  const DonasiEmpatPage({
    super.key,
    required this.institutionName,
    required this.institutionImage,
    required this.nominal,
    required this.adminFee,
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
    final int totalAmount = nominal + adminFee;

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
                      child: Image.asset(
                        institutionImage,
                        width: 32.w,
                        height: 32.h,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.account_balance,
                            color: Colors.grey[400],
                            size: 20.r,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      institutionName,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Donasi',
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
                        _formatRupiah(nominal),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonasiLimaPage(
                        institutionName: institutionName,
                        institutionImage: institutionImage,
                        nominal: nominal,
                        adminFee: adminFee,
                      ),
                    ),
                  );
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
}
