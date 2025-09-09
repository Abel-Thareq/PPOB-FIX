import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/einvoicing/presentation/pages/einvoicing_tiga.dart';

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

// Placeholder untuk CustomButton agar kode ini dapat dijalankan.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    );
  }
}

class EinvoicingDuaPage extends StatefulWidget {
  final String publisher;
  final String paymentCode;

  const EinvoicingDuaPage({
    super.key,
    required this.publisher,
    required this.paymentCode,
  });

  @override
  State<EinvoicingDuaPage> createState() => _EinvoicingDuaPageState();
}

class _EinvoicingDuaPageState extends State<EinvoicingDuaPage> {
  bool _isSavedListActive = false;

  // Data dummy untuk contoh tampilan
  final String namaPelanggan = "Alfin Chipmunk";
  final int totalTagihan = 1500000;
  final int biayaAdmin = 0;
  final String npwp = "12.345.678.9-012.000";
  final String jenisPajak = "PPh Pasal 21";
  final String kodeAkunPajak = "411121";
  final String kodeJenisSet = "100";

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                    margin: EdgeInsets.symmetric(horizontal: 0),
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
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        _DetailRow("Kode Pembayaran", widget.paymentCode),
                        _DetailRow("Penerbit E-Invoice", widget.publisher),
                        _DetailRow("Nama WP", namaPelanggan),
                        _DetailRow("NPWP", npwp),
                        _DetailRow("Jenis Pajak", jenisPajak),
                        _DetailRow("Kode Akun Pajak", kodeAkunPajak),
                        _DetailRow("Kode Jenis Set", kodeJenisSet),
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
          ),

          // Tombol "Bayar Sekarang" di bagian bawah
          Padding(
            padding: EdgeInsets.all(24.w),
            child: CustomButton(
              text: 'Bayar Sekarang',
              onPressed: () {
                // Tambahkan logika navigasi ke EinvoicingTigaPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EinvoicingTigaPage(
                      publisher: widget.publisher,
                      paymentCode: widget.paymentCode,
                    ),
                  ),
                );
              },
              backgroundColor: const Color(0xFF6C4EFF),
            ),
          ),
        ],
      ),
    );
  }
}
