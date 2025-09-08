import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/home/presentation/pages/topupgame_page.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'dart:math';

// Ini adalah halaman yang akan ditampilkan jika transaksi gagal
class TopUpGameEmpatGagal extends StatefulWidget {
  final String gameTitle;
  final String gameId;
  final String serverId;
  final String selectedDiamond;
  final String price;

  const TopUpGameEmpatGagal({
    super.key,
    required this.gameTitle,
    required this.gameId,
    required this.serverId,
    required this.selectedDiamond,
    required this.price,
  });

  @override
  State<TopUpGameEmpatGagal> createState() => _TopUpGameEmpatGagalState();
}

class _TopUpGameEmpatGagalState extends State<TopUpGameEmpatGagal> {
  // Fungsi untuk memformat mata uang
  String formatCurrency(String amount) {
    try {
      final int parsedAmount = int.parse(amount);
      return NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      ).format(parsedAmount);
    } catch (e) {
      return 'Rp0';
    }
  }

  // Fungsi untuk membuat nomor referensi acak
  String _generateRandomString(int length) {
    final random = Random();
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // Fungsi untuk menangani navigasi kembali ke halaman utama
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final horizontalPadding = 24.w;

    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now);
    final noRef = _generateRandomString(20);
    const idTransaksi = "971411A3FF0B8A45"; // Contoh ID Transaksi
    const sumberDanaNama = "ABEL THAREQ";
    const sumberDanaNomor = "081215633163";

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 22.h),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              iconSize: 28.r,
              onPressed: _onBackPressed,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            // Header Background Image (Sudah dikecilkan)
            SizedBox(
              height: 100.h,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),

            // Konten utama yang dapat digulir (padding sudah disesuaikan)
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 120.h, bottom: 20.h, left: horizontalPadding, right: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png', // Anda harus memiliki aset gambar ini
                    width: 60.w,
                    height: 60.w,
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

                  // Box informasi gagal dengan detail transaksi
                  Container(
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
                        _DetailRow("Tanggal", formattedDate),
                        _DetailRow("No. Ref", noRef),
                        Divider(height: 24.h, thickness: 1),
                        _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                        _DetailRow("Jenis Transaksi", "Top Up Game"),
                        _DetailRow("Nominal", widget.selectedDiamond),
                        _DetailRow("ID Game", '${widget.gameId} (${widget.serverId})'),
                        _DetailRow("ID Transaksi", idTransaksi),
                        _DetailRow("Nama Game", widget.gameTitle),
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
                                formatCurrency(widget.price),
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const MainScreen()),
                                    (Route<dynamic> route) => false,
                              );
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const TopUpGamePage()),
                                    (Route<dynamic> route) => false,
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
          ],
        ),
      ),
    );
  }
}

// Widget pembantu untuk baris detail
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String? value2;

  const _DetailRow(this.label, this.value, {this.value2});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
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
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              if (value2 != null)
                Text(
                  value2!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget placeholder untuk CustomButton
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
    ScreenUtil.init(context, designSize: const Size(360, 690));
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: borderColor ?? const Color(0xFF6C4EFF),
          side: BorderSide(color: borderColor ?? const Color(0xFF6C4EFF)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp)),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? const Color(0xFF6C4EFF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp)),
      );
    }
  }
}
