import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPembayaranPopup extends StatelessWidget {
  final int nominal;
  final int biayaAdmin;
  final int total;

  const DetailPembayaranPopup({
    super.key,
    required this.nominal,
    required this.biayaAdmin,
    required this.total,
  });

  String _formatRupiah(int value) {
    return "Rp${value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => "${m[1]}.",
    )}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( // ✅ biar aman dari notch
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min, // ✅ penting biar popup wrap content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            // Title
            Center(
              child: Text(
                "Detail Pembayaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Nominal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Nominal",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Text(_formatRupiah(nominal),
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
            SizedBox(height: 6.h),

            // Biaya Admin
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Biaya Admin",
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Text(_formatRupiah(biayaAdmin),
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
            SizedBox(height: 6.h),
            const Divider(),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text("Total Pembayaran",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down,
                        size: 18, color: Colors.grey),
                  ],
                ),
                Text(
                  _formatRupiah(total),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Tombol Beli Sekarang
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                onPressed: () {
                  Navigator.pop(context); // ✅ tutup popup
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Beli Sekarang ditekan")),
                  );
                },
                child: const Text(
                  "Beli Sekarang",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}