import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

/// 🔹 Helper langsung di file ini
String getBankLogo(String bankName) {
  switch (bankName) {
    case "Bank BRI":
      return "assets/images/bank_bri.png";
    case "Bank Mandiri":
      return "assets/images/bank_mandiri.png";
    case "Bank BNI":
      return "assets/images/bank_bni.png";
    case "Bank BCA":
      return "assets/images/bank_bca.png";
    case "Bank BSI":
      return "assets/images/bank_bsi.png";
    case "Bank BTN":
      return "assets/images/bank_btn.png";
    case "Bank CIMB NIAGA":
      return "assets/images/bank_cimb.png";
    case "Bank DANAMON":
      return "assets/images/bank_danamon.png";
    case "Bank PERMATA":
      return "assets/images/bank_permata.png";
    case "Bank PANIN":
      return "assets/images/bank_panin.png";
    default:
      return "assets/images/default_bank.png";
  }
}

class StrukTransferPage extends StatelessWidget {
  final String noRef;
  final String bankName;
  final String rekeningNumber;
  final String namaPenerima;
  final int nominal;
  final int biayaAdmin;
  final int total;
  final String catatan;
  final DateTime tanggal;

  const StrukTransferPage({
    super.key,
    required this.noRef,
    required this.bankName,
    required this.rekeningNumber,
    required this.namaPenerima,
    required this.nominal,
    required this.biayaAdmin,
    required this.total,
    required this.catatan,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final NumberFormat formatter = NumberFormat("#,###", "id_ID");
    final tanggalFormat =
        DateFormat("dd MMM yyyy HH:mm", "id_ID").format(tanggal);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header atas
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
                      icon:
                          Icon(Icons.arrow_back, size: 28.r, color: Colors.white),
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
                Positioned(
                  bottom: 0,
                  left: 24.w,
                  right: 24.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6.r,
                          offset: Offset(0, 3.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Detail Transaksi',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Card utama struk
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 🔹 HeaderStruk
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                      child: Image.asset(
                        "assets/images/headerstruk.png",
                        width: double.infinity,
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // 🔹 Tanggal + ID Modipay
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tanggalFormat,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                              const Text(
                                "ID Modipay 0813****7404",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ],
                          ),
                          const Divider(height: 20),

                          // 🔹 Status & No Ref
                          Row(
                            children: const [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 18),
                              SizedBox(width: 4),
                              Text("Transaksi Berhasil",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "No. Ref",
                                style: TextStyle(fontSize: 12, color: Colors.black54),
                              ),
                              Text(
                                noRef,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          // 🔹 Info penerima
                          Row(
                            children: [
                              Image.asset(
                                getBankLogo(bankName),
                                width: 50.w,
                                height: 50.w,
                              ),
                              SizedBox(width: 14.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    namaPenerima,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    bankName,
                                    style: TextStyle(
                                      fontSize: 14,
                                      // ignore: deprecated_member_use
                                      color: Colors.black.withOpacity(0.4), // ✅ fade
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    rekeningNumber,
                                    style: TextStyle(
                                      fontSize: 14,
                                      // ignore: deprecated_member_use
                                      color: Colors.black.withOpacity(0.4), // ✅ fade
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // 🔹 Informasi Pembayaran
                          const Text(
                            "Informasi Pembayaran",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          Divider(),
                          _buildRow("Metode Pembayaran", "Saldo Modipay"),
                          _buildRow(
                            "Jumlah Pesanan",
                            "Rp ${formatter.format(nominal).replaceAll(",", ".")}",
                          ),
                          _buildRow(
                            "Biaya Admin",
                            "Rp ${formatter.format(biayaAdmin).replaceAll(",", ".")}",
                          ),
                          Divider(),
                          _buildRow(
                            "Total Transaksi",
                            "Rp ${formatter.format(total).replaceAll(",", ".")}",
                            bold: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔹 Button Bagikan
          Container(
            margin: EdgeInsets.all(16.w),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5938FB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              onPressed: () {
                // TODO: fitur share struk
              },
              child: const Text(
                "Bagikan",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}