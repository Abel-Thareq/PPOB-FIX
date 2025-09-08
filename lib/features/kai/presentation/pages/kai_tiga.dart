import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/kai/presentation/pages/kai_empat.dart';

class KaiTigaPage extends StatefulWidget {
  final String kodeBayar;

  const KaiTigaPage({
    super.key,
    required this.kodeBayar
  });

  @override
  State<KaiTigaPage> createState() => _KaiTigaPageState();
}

class _KaiTigaPageState extends State<KaiTigaPage> {
  // State untuk melacak apakah "Tambah Ke Daftar Tersimpan" aktif
  bool _isSavedListActive = false;

  // Data dummy untuk contoh tampilan
  final String namaPelanggan = "Alfin Chipmunk";
  final int totalTagihan = 230000;
  final int biayaAdmin = 0;
  final String periodeTagihan = "20 Agustus 2026";
  final String stasiunAsal = 'Lempuyangan (LPY)';
  final String stasiunTujuan = 'Pasar Senen (PSE)';

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
    final totalPembayaran = totalTagihan + biayaAdmin;
    final screenWidth = MediaQuery.of(context).size.width;

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
              child: const Text(
                "Tagihan",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C4EFF),
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
                Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  formatCurrency(totalPembayaran),
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
                  margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
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
                      _DetailRow("Nama Pelanggan", namaPelanggan),
                      _DetailRow("Kode Pembayaran", widget.kodeBayar),
                      _DetailRow("Stasiun Asal", stasiunAsal),
                      _DetailRow("Stasiun Tujuan", stasiunTujuan),
                      _DetailRow("Tanggal", periodeTagihan),
                      Divider(height: 24.h, thickness: 1),
                      _DetailRow("Tagihan", formatCurrency(totalTagihan)),
                      _DetailRow("Biaya Admin", formatCurrency(biayaAdmin)),
                      Divider(height: 24.h, thickness: 1),
                      Container(
                        padding: EdgeInsets.all(12.w),
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
                              formatCurrency(totalPembayaran),
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
              child: CustomButton(
                text: 'Bayar Sekarang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KaiEmpatPage(
                        kodeBayar: widget.kodeBayar,
                        nominalTagihan: totalPembayaran, biayaAdmin: biayaAdmin,
                        namaPelanggan: namaPelanggan,
                      ),
                    ),
                  );
                },
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

  // ignore: unused_element_parameter
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

// CustomButton widget sebagai contoh
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6A1B9A),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
