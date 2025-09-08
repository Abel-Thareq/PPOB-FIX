import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class StrukPulsaPageGagal extends StatelessWidget {
  final String sumberDana;
  final String tujuan;
  final int harga;
  final int biayaAdmin;
  final int total;
  final DateTime tanggal;

  const StrukPulsaPageGagal({
    super.key,
    required this.sumberDana,
    required this.tujuan,
    required this.harga,
    required this.biayaAdmin,
    required this.total,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final NumberFormat formatter = NumberFormat("#,###", "id_ID");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header
          SizedBox(
            height: 135.h,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: 28.r, color: Colors.white),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Icon gagal & judul
          const Icon(Icons.cancel, color: Colors.red, size: 48),
          SizedBox(height: 8.h),
          const Text(
            "Transaksi Gagal",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          SizedBox(height: 16.h),

          // 🔹 Box Struk
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(
                  "Tanggal",
                  "${DateFormat("dd MMM yyyy HH:mm:ss", "id_ID").format(tanggal)} WIB",
                ),
                _buildRow("No. Ref", "-"),
                const Divider(),

                _buildRow("Sumber Dana", sumberDana),
                _buildRow("Tujuan", tujuan),
                _buildRow("Nomor Serial", "-"),
                const Divider(),

                _buildRow("Harga", "Rp${formatter.format(harga)}"),
                _buildRow("Biaya Admin", "Rp${formatter.format(biayaAdmin)}"),
              ],
            ),
          ),

          // 🔹 Box Total
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Pembelian",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(
                  "Rp${formatter.format(total)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF5938FB),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // 🔹 Button Kembali + Coba Lagi
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // coba lagi balik ke PIN misalnya
                    },
                    child: const Text(
                      "Coba Lagi",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}