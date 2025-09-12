import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/pajak%20daerah/presentation/pages/pajakdaerah_empat.dart';

class PajakDaerahTigaPage extends StatefulWidget {
  final String provinceName;
  final String provinceImage;
  final String cityName;
  final String tagihanNumber;

  const PajakDaerahTigaPage({
    super.key,
    required this.provinceName,
    required this.provinceImage,
    required this.cityName,
    required this.tagihanNumber,
  });

  @override
  State<PajakDaerahTigaPage> createState() => _PajakDaerahTigaPageState();
}

class _PajakDaerahTigaPageState extends State<PajakDaerahTigaPage> {
  bool _isSavedListActive = false;
  
  // Data dummy untuk contoh tampilan (bisa disesuaikan dengan data sebenarnya)
  final int totalTagihan = 500000;
  final int biayaAdmin = 0;
  final String namaWajibBayar = "ALFIN CHIPMUNK";
  final String npwpNik = "12.345.673.9-012.000";
  final String jenisPajak = "BPHTB";
  final String alamatObjek = "JL Pemuda No. 45, Jakarta Selatan";

  // Fungsi untuk memformat mata uang ke format Rupiah
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final totalPembayaran = totalTagihan + biayaAdmin;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Column(
        children: [
          // Header Background Image & "Tagihan" Box
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
                    onPressed: () => navigateBack(context),
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
                        color: Color(0xFF6A1B9A),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 35.h),

          // Konten utama yang dapat digulir
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Total Tagihan",
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
                      color: const Color(0xFF6A1B9A),
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
                      activeColor: const Color(0xFF6A1B9A),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Box detail tagihan pajak
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
                        _DetailRow("Sumber Dana", "ABEL THAREQ"),
                        _DetailRow("Nomor Tagihan", widget.tagihanNumber),
                        _DetailRow("Nama Wajib Bayar", namaWajibBayar),
                        _DetailRow("NPWP / NIK", npwpNik),
                        _DetailRow("Jenis Pajak", jenisPajak),
                        _DetailRow("Alamat Objek", alamatObjek),
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
                                  color: const Color(0xFF6A1B9A),
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
                    builder: (context) => PajakDaerahEmpatPage(
                      provinceName: widget.provinceName,
                      provinceImage: widget.provinceImage,
                      cityName: widget.cityName,
                      tagihanNumber: widget.tagihanNumber,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A1B9A),
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