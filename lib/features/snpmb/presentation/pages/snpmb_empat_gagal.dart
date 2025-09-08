import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Asumsikan file-file ini sudah ada di proyek Anda.
// Sesuaikan path import jika diperlukan.
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/snpmb/presentation/pages/snpmb_page.dart';

class SnpmbEmpatGagalPage extends StatelessWidget {
  final String namaPelanggan;
  final String jenisUjian;
  final int tagihan;
  final int biayaAdmin;
  final int totalTagihan;

  const SnpmbEmpatGagalPage({
    super.key,
    required this.namaPelanggan,
    required this.jenisUjian,
    required this.tagihan,
    required this.biayaAdmin,
    required this.totalTagihan,
  });

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Fungsi navigasi untuk kembali ke MainScreen dan menghapus semua rute sebelumnya.
  void navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double headerHeight = 120.h;
    final String tanggalWaktu = DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.now());
    const String noRef = "-";
    const String sumberDanaNama = "ABEL THAREO";
    const String sumberDanaNomor = "09275633163";

    return PopScope(
      // Mengubah perilaku tombol kembali bawaan HP Android
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        navigateToMainScreen(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            // Gambar header di lapisan paling bawah
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              // TODO: Ganti path aset gambar dengan yang benar
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            // Tombol kembali yang diposisikan di atas gambar header
            Positioned(
              top: 50.h,
              left: 10.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28.r,
                onPressed: () {
                  navigateToMainScreen(context);
                },
              ),
            ),
            // Konten halaman di lapisan atas
            Padding(
              padding: EdgeInsets.only(top: headerHeight),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TODO: Ganti path aset gambar dengan yang benar
                    Image.asset(
                      'assets/images/error.png',
                      width: 40.w,
                      height: 40.h,
                    ),
                    SizedBox(height: 13.h),
                    Text(
                      "Transaksi Gagal",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
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
                          _DetailRow("Tanggal", tanggalWaktu),
                          _DetailRow("No. Ref", noRef),
                          Divider(height: 24.h, thickness: 1),
                          _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                          _DetailRow("Jenis Transaksi", "Pembayaran $jenisUjian"),
                          _DetailRow("Nama Pelanggan", namaPelanggan),
                          _DetailRow("Nomor Pelanggan", "-"), // Anggap nomor pelanggan tidak ada
                          Divider(height: 24.h, thickness: 1),
                          _DetailRow("Tagihan", formatCurrency(tagihan)),
                          _DetailRow("Biaya Admin", formatCurrency(biayaAdmin)),
                          Divider(height: 24.h, thickness: 1),
                          Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Tagihan",
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
                                    color: const Color(0xFF6C4EFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: CustomButton(
                              text: 'Kembali',
                              onPressed: () {
                                navigateToMainScreen(context);
                              },
                              isOutlined: true,
                              borderColor: Colors.red,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: CustomButton(
                              text: 'Coba Lagi',
                              // Mengubah navigasi untuk tombol "Coba Lagi"
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const SnpmbPage()),
                                );
                              },
                              buttonColor: Colors.red,
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 150.w),
                child: AutoSizeText(
                  value,
                  maxLines: 1,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              if (value2 != null)
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 150.w),
                  child: AutoSizeText(
                    value2!,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Color? buttonColor;
  final Color? borderColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.buttonColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: borderColor ?? Colors.black,
          side: BorderSide(color: borderColor ?? Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? const Color(0xFF5938FB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: Text(text),
      );
    }
  }
}
