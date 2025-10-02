import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';

class StrukTagihanPropertiGagalPage extends StatefulWidget {
  final String noRef;
  final Map<String, dynamic> invoiceData;
  final DateTime tanggal;

  const StrukTagihanPropertiGagalPage({
    super.key,
    required this.noRef,
    required this.invoiceData,
    required this.tanggal,
  });

  @override
  State<StrukTagihanPropertiGagalPage> createState() =>
      _StrukTagihanPropertiGagalPageState();
}

class _StrukTagihanPropertiGagalPageState
    extends State<StrukTagihanPropertiGagalPage> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');

    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 110.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6C4DF6), Color(0xFF4B2FB7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              "modipay",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "SATU PINTU SEMUA PEMBAYARAN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 48.w,
                    height: 48.h,
                  ),
                  SizedBox(height: 16.h),
                  const Text(
                    "Transaksi Gagal",
                    style: TextStyle(
                      color: Color(0xFFE11D48),
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tanggal",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "10 Mar 2025, 20:13:38 WIB",
                              style: const TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "No. Ref",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "-",
                              style: const TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 24.h, color: const Color(0xFFE2E8F0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Sumber Dana",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "ABEL THAREQ",
                                  style: TextStyle(
                                    color: Color(0xFF1E293B),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "081215633163",
                                  style: TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 10,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Jenis Transaksi",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Bayar IPL & Properti",
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Nama",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "ALFIN CHIPMUNK",
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Nomor Pelanggan",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "0012345",
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        if (!_showDetails) ...[
                          InkWell(
                            onTap: () => setState(() => _showDetails = true),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Lihat Detail Transaksi",
                                  style: TextStyle(
                                    color: Color(0xFFE11D48),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFFE11D48),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Alamat",
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "CitraLand BSB Semarang",
                                      style: const TextStyle(
                                        color: Color(0xFF1E293B),
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Cluster Havana Blok A3 No.15",
                                    style: const TextStyle(
                                      color: Color(0xFF1E293B),
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Mijen, Semarang",
                                    style: const TextStyle(
                                      color: Color(0xFF1E293B),
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Tanggal",
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "20 Agustus 2025",
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Periode Tagihan",
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Bulanan",
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          InkWell(
                            onTap: () => setState(() => _showDetails = false),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Lihat Lebih Sedikit",
                                  style: TextStyle(
                                    color: Color(0xFFE11D48),
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Color(0xFFE11D48),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                        Divider(height: 24.h, color: const Color(0xFFE2E8F0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Harga",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Rp50.000",
                              style: const TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Denda",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Rp0",
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Biaya Admin",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Rp0",
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Total Pembelian",
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Rp50.000",
                                style: TextStyle(
                                  color: Color(0xFF6C4DF6),
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xFFE11D48),
                              width: 1,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Kembali",
                            style: TextStyle(
                              color: Color(0xFFE11D48),
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE11D48),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            minimumSize: Size(double.infinity, 48.h),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Coba Lagi",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
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
