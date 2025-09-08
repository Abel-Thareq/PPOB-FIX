import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/asuransi/presentation/pages/asuransi_lima.dart';

class AsuransiEmpatPage extends StatelessWidget {
  final String insuranceType;
  final String paymentType;
  final String policyNumber;
  final String namaPemegang;
  final int tagihan;
  final int biayaAdmin;
  final int nominalPembayaran;
  final String insuranceIconPaths;

  const AsuransiEmpatPage({
    super.key,
    required this.insuranceType,
    required this.paymentType,
    required this.policyNumber,
    required this.namaPemegang,
    required this.tagihan,
    required this.biayaAdmin,
    required this.nominalPembayaran,
    required this.insuranceIconPaths,
  });

  // Fungsi untuk memformat mata uang ke format Rupiah
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    final double horizontalPadding = 24.w;
    final int total = tagihan + biayaAdmin;

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
                      color: const Color(0xFF5938FB),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF5938FB),
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
                      'modipay - 08725633863',
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
                      color: const Color(0xFF5938FB),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                        child: Image.asset(
                          insuranceIconPaths,
                          width: 32.w,
                          height: 32.h,
                      ),
                    ),
                    title: Text(
                      namaPemegang,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      policyNumber,
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
                          activeColor: const Color(0xFF5938FB),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Divider(height: 1.h, thickness: 1),
                  SizedBox(height: 16.h),

                  // Bagian "Detail Pembayaran"
                  Text(
                    'Detail Pembayaran',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5938FB),
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
                        formatCurrency(nominalPembayaran),
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
                        formatCurrency(biayaAdmin),
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Menampilkan Jenis Asuransi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis Asuransi',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: AutoSizeText(
                          insuranceType,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          minFontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Menampilkan Tipe Pembayaran
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tipe Pembayaran',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),
                      Text(
                        paymentType,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(height: 1.h, thickness: 1),
                  SizedBox(height: 16.h),

                  // Menampilkan Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
                        ),
                      ),
                      Text(
                        formatCurrency(total),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
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
                      builder: (context) => AsuransiLimaPage(
                        insuranceType: insuranceType,
                        paymentType: paymentType,
                        policyNumber: policyNumber,
                        namaPemegang: namaPemegang,
                        tagihan: tagihan,
                        biayaAdmin: biayaAdmin,
                        nominalPembayaran: nominalPembayaran,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
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