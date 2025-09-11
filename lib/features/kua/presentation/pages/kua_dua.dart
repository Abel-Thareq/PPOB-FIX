import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/kua/presentation/pages/kua_tiga.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class KuaDuaPage extends StatefulWidget {
  final String billingCode;

  const KuaDuaPage({
    super.key,
    required this.billingCode,
  });

  @override
  State<KuaDuaPage> createState() => _KuaDuaPageState();
}

class _KuaDuaPageState extends State<KuaDuaPage> {
  // State untuk melacak apakah "Tambah Ke Daftar Tersimpan" aktif
  bool _isSavedListActive = false;

  // Data dummy untuk contoh tampilan E-Tilang
  final String sumberDana = "ABEL THAREQ";
  final int totalTagihan = 250000;
  final int biayaAdmin = 0;
  final String namaPemohon = "ALFIN CHIPMUNK";
  final String layanan = "Pencatatan Nikah";
  final String lokasiNikah = "Luar Kantor KUA";
  final String tanggalNikah = "20 September 2025";

  // Fungsi untuk memformat mata uang ke format Rupiah
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Fungsi untuk navigasi kembali ke MainScreen
  void _navigateToMainScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final totalPembayaran = totalTagihan + biayaAdmin;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Column(
        children: [
          // Header Background Image & "Tilang" Box
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 140.h,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16.h,
                left: 16.w,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 28.r,
                    onPressed: _navigateToMainScreen,
                  ),
                ),
              ),
              Positioned(
                bottom: -25.h,
                left: 0,
                right: 0,
                child: Center(
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
              ),
            ],
          ),
          SizedBox(height: 35.h), // Spasi untuk box yang tumpang tindih

          // Konten utama yang dapat digulir
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Denda",
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
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                        "Tambah ke Daftar Tersimpan",
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

                  // Box detail tilang
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        _DetailRow("Sumber Dana", sumberDana),
                        _DetailRow("Kode Billing", widget.billingCode),
                        _DetailRow("Nama Pemohon", namaPemohon),
                        _DetailRow("Layanan", layanan),
                        _DetailRow("Lokasi Nikah", lokasiNikah),
                        _DetailRow("Tanggal Nikah", tanggalNikah),
                        SizedBox(height: 16.h),
                        Divider(height: 1.h, thickness: 1, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        _DetailRow("Tagihan", formatCurrency(totalTagihan)),
                        _DetailRow("Biaya Admin", formatCurrency(biayaAdmin)),
                        SizedBox(height: 16.h),
                        Divider(height: 1.h, thickness: 1, color: Colors.grey.shade300),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8FF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Pembayaran",
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
          ),

          // Tombol "Bayar Sekarang" di bagian bawah
          Padding(
            padding: EdgeInsets.all(24.w),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KuaTigaPage(
                      billingCode: widget.billingCode,
                      totalTagihan: formatCurrency(totalTagihan),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C4EFF),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Bayar Sekarang',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
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

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
