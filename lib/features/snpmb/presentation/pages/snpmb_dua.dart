import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/snpmb/presentation/pages/snpmb_tiga.dart';

// Halaman untuk menampilkan detail tagihan SNMPB
class SnpmbDuaPage extends StatefulWidget {
  final String kodePembayaran;
  final String nisn;

  const SnpmbDuaPage({
    super.key,
    required this.kodePembayaran,
    required this.nisn,
  });

  @override
  State<SnpmbDuaPage> createState() => _SnpmbDuaPageState();
}

class _SnpmbDuaPageState extends State<SnpmbDuaPage> {
  // State untuk melacak apakah "Tambah Ke Daftar Tersimpan" aktif
  bool _isSavedListActive = false;

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
    final screenWidth = MediaQuery.of(context).size.width;

    // Data dummy untuk detail tagihan SNMPB
    const namaPelanggan = "Nabil Ahmad";
    const tanggalLahir = "20 Oktober 2005";
    const jenisUjian = "SNMPB";
    const tagihan = 200000;
    const biayaAdmin = 5000;
    final totalTagihan = tagihan + biayaAdmin;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // Header Background Image
          SizedBox(
            height: 140.h,
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
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Box "Tagihan" yang tumpang tindih
          Positioned(
            top: 110.h,
            left: (screenWidth - 150.w) / 2, // Posisi horizontal di tengah
            right: (screenWidth - 150.w) / 2,
            child: Container(
              width: 150.w,
              height: 50.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6.r,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                "Tagihan",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6C4EFF),
                ),
              ),
            ),
          ),

          // Konten utama yang dapat digulir
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 170.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bagian Total Tagihan di luar box
                const Text(
                  "Total Tagihan",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  formatCurrency(totalTagihan),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6C4EFF),
                  ),
                ),
                SizedBox(height: 20.h),

                // Box "Tambah Ke Daftar Tersimpan"
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                  child: SwitchListTile(
                    title: Text(
                      "Tambah Ke Daftar Tersimpan",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    value: _isSavedListActive,
                    onChanged: (bool value) {
                      setState(() {
                        _isSavedListActive = value;
                      });
                    },
                    activeColor: const Color(0xFF6C4EFF),
                  ),
                ),
                SizedBox(height: 20.h),

                // Box detail tagihan
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
                      _DetailRow("Sumber Dana", "ABEL THAREQ", value2: "081390147404"),
                      _DetailRow("Nama Pelanggan", namaPelanggan),
                      _DetailRow("NISN", widget.nisn),
                      _DetailRow("Tanggal Lahir", tanggalLahir),
                      _DetailRow("Jenis Ujian", jenisUjian),
                      const Divider(height: 24, thickness: 1),
                      _DetailRow("Tagihan", formatCurrency(tagihan)),
                      _DetailRow("Biaya Admin", formatCurrency(biayaAdmin)),
                      const Divider(height: 24, thickness: 1),
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
              ],
            ),
          ),

          // Tombol "Bayar Sekarang" di bagian bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SnpmbTigaPage(
                        namaPelanggan: namaPelanggan,
                        jenisUjian: jenisUjian,
                        tagihan: tagihan,
                        biayaAdmin: biayaAdmin,
                        totalTagihan: totalTagihan,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  elevation: 0,
                ),
                child: Text(
                  "Bayar Sekarang",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
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

// Widget pembantu untuk baris detail
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
