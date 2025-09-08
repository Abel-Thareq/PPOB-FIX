import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class StrukEWalletFailedPage extends StatelessWidget {
  final String sumberDana;
  final String jenisTransaksi;
  final String nama;
  final String nomorTujuan;
  final int harga;
  final int biayaAdmin;
  final DateTime tanggal;

  final String ewalletName;
  final int total;

  const StrukEWalletFailedPage({
    super.key,
    required this.sumberDana,
    required this.jenisTransaksi,
    required this.nama,
    required this.nomorTujuan,
    required this.harga,
    required this.biayaAdmin,
    required this.tanggal,
    required this.ewalletName,
    required this.total,
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
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // 🔹 Icon silang merah & judul
          const Icon(Icons.cancel, color: Colors.red, size: 48),
          SizedBox(height: 8.h),
          const Text(
            "Transaksi Gagal",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
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
                _buildRow("Tanggal",
                    "${DateFormat("dd MMM yyyy HH:mm:ss", "id_ID").format(tanggal)} WIB"),
                _buildRow("No. Ref", "-"), // ❌ Transaksi gagal biasanya tidak ada no ref
                Divider(),

                _buildRow("Sumber Dana", sumberDana),
                _buildRow("Jenis Transaksi", jenisTransaksi),
                _buildRow("Nama", nama),
                _buildRow("Nomor Tujuan", nomorTujuan),
                Divider(),

                _buildRow("Harga", "Rp${formatter.format(harga)}"),
                _buildRow("Biaya Admin", "Rp${formatter.format(biayaAdmin)}"),
              ],
            ),
          ),

          // 🔹 Box Total Pembelian
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
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                Text(
                  "Rp${formatter.format(total)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red),
                ),
              ],
            ),
          ),

          const Spacer(),

          // 🔹 Button Coba Lagi
          Container(
            margin: EdgeInsets.all(16.w),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () {
                Navigator.pop(context); // kembali ke halaman sebelumnya untuk coba ulang
              },
              child: const Text("Coba Lagi",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
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