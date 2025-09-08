import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Impor untuk fungsionalitas Clipboard
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'dart:math';

// Ini adalah halaman yang akan ditampilkan jika transaksi berhasil
class TopUpGameEmpatBerhasil extends StatefulWidget {
  final String gameTitle;
  final String gameId;
  final String serverId;
  final String selectedDiamond;
  final String price;

  const TopUpGameEmpatBerhasil({
    super.key,
    required this.gameTitle,
    required this.gameId,
    required this.serverId,
    required this.selectedDiamond,
    required this.price,
  });

  @override
  State<TopUpGameEmpatBerhasil> createState() => _TopUpGameEmpatBerhasilState();
}

class _TopUpGameEmpatBerhasilState extends State<TopUpGameEmpatBerhasil> {
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

  // Fungsi untuk menyalin detail transaksi dan menampilkan notifikasi
  void _shareTransactionDetails() {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now);
    final noRef = _generateRandomString(20);
    const idTransaksi = "971411A3FF0B8A45"; // Contoh ID Transaksi
    const sumberDanaNama = "ABEL THAREQ";
    const sumberDanaNomor = "081215633163";
    final totalPembelian = formatCurrency(widget.price);

    final details = """
Transaksi Berhasil!

Detail Transaksi:
----------------------------------------
Tanggal: $formattedDate
No. Ref: $noRef
Sumber Dana: $sumberDanaNama ($sumberDanaNomor)
Jenis Transaksi: Top Up Game
Nominal: ${widget.selectedDiamond}
ID Game: ${widget.gameId} (${widget.serverId})
ID Transaksi: $idTransaksi
Nama Game: ${widget.gameTitle}
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

    // Mendapatkan tanggal dan waktu saat ini
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

            // Tombol kembali di atas header
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

            // Konten utama yang dapat digulir (padding sudah disesuaikan)
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 120.h, bottom: 20.h, left: horizontalPadding, right: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon ceklis
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    "Transaksi Berhasil",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // Box detail transaksi
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
                            text: 'Bagikan',
                            onPressed: _shareTransactionDetails,
                            isOutlined: true,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: CustomButton(
                            text: 'Selesai',
                            onPressed: _onBackPressed,
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
