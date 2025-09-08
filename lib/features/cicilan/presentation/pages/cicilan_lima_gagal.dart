import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
// Asumsikan file-file ini sudah ada di proyek Anda
import 'package:ppob_app/features/cicilan/presentation/pages/cicilan_dua.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class CicilanLimaGagal extends StatelessWidget {
  final String selectedProviderName;
  final String nomorPelanggan;
  final int totalTagihan;
  final int biayaAdmin;
  final String namaPelanggan;
  final String jatuhTempo;
  final int angsuranKe;

  const CicilanLimaGagal({
    super.key,
    required this.selectedProviderName,
    required this.nomorPelanggan,
    required this.totalTagihan,
    required this.biayaAdmin,
    required this.namaPelanggan,
    required this.jatuhTempo,
    required this.angsuranKe,
  });

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Fungsi navigasi yang akan digunakan oleh kedua tombol kembali
  void navigateToMainScreen(BuildContext context) {
    // Navigasi ke MainScreen dan hapus semua rute sebelumnya di stack navigasi
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
      // Mencegah pop default saat tombol kembali fisik ditekan
      canPop: false, 
      onPopInvoked: (didPop) {
        // Jika pop tidak terjadi, lakukan navigasi kustom
        if (!didPop) {
          navigateToMainScreen(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        // Gunakan Stack untuk mengatur tata letak header dan konten
        body: Stack(
          children: [
            // Gambar header di lapisan paling bawah
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            // Tombol kembali yang diposisikan di atas gambar header
            Positioned(
              top: 50.h, // Atur posisi vertikal
              left: 10.w,  // Atur posisi horizontal
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
            // Tambahkan padding di bagian atas agar tidak tertutup header
            Padding(
              padding: EdgeInsets.only(top: headerHeight),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                          _DetailRow("Jenis Transaksi", "Pembayaran Cicilan $selectedProviderName"),
                          _DetailRow("Nama Pelanggan", namaPelanggan),
                          _DetailRow("Nomor Pelanggan", nomorPelanggan),
                          Divider(height: 24.h, thickness: 1),
                          _DetailRow("Harga", formatCurrency(totalTagihan)),
                          _DetailRow("Denda", "Rp0"),
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
                                  "Total Pembelian",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  formatCurrency(totalTagihan + biayaAdmin),
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
                              onPressed: () {
                                // Navigasi ke CicilanDuaPage dan hapus rute saat ini
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CicilanDuaPage()),
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
              // Menggunakan AutoSizeText untuk menghindari overflow
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 150.w), // Atur batasan lebar
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
                  constraints: BoxConstraints(maxWidth: 150.w), // Atur batasan lebar
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
