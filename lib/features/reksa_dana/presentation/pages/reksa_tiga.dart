import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/home/presentation/pages/tagihan_page.dart';

class ReksaTigaPage extends StatefulWidget {
  const ReksaTigaPage({super.key});

  @override
  State<ReksaTigaPage> createState() => _ReksaTigaPageState();
}

class _ReksaTigaPageState extends State<ReksaTigaPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const TagihanPage()),
          (route) => false,
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            // HEADER - PAKAI IMAGE ASSET DAN DUA BOX YANG MELAYANG
            SizedBox(
              height: 200.h, // Menambah tinggi header untuk mengakomodasi box yang melayang
              child: Stack(
                children: [
                  // Gambar header
                  SizedBox(
                    width: double.infinity,
                    height: 120.h,
                    child: Image.asset(
                      "assets/images/header.png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Tombol back di atas gambar
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 28.r),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const TagihanPage()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),

                  // BOX "SATU PINTU SEMUA PEMBAYARAN" melayang di bawah header
                  Positioned(
                    bottom: 70.h, // Posisi di atas box Total Investasi
                    left: 24.w,
                    right: 24.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(6.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6.r,
                            offset: Offset(0, 3.h),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'SATU PINTU SEMUA PEMBAYARAN',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // BOX TOTAL INVESTASI yang melayang
                  Positioned(
                    bottom: 0, // Diletakkan di bagian bawah Stack
                    left: 24.w,
                    right: 24.w,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          // Bagian atas ungu
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.r),
                                topRight: Radius.circular(12.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Investasi",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "Rp0",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.visibility_off, color: Colors.white, size: 24.r),
                              ],
                            ),
                          ),

                          // Bagian bawah abu-abu
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.r),
                                bottomRight: Radius.circular(12.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Keuntungan",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "Rp0",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Kenaikan",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "0%",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
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
                  ),
                ],
              ),
            ),

            // KONTEN
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 16.h,
                  left: 24.w,
                  right: 24.w,
                  bottom: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h), // Spacer tambahan

                    // Pilih Produk Reksa Dana
                    Text(
                      "Pilih Produk Reksa Dana",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Produk 1: STAR Infobank 15 Saham
                    _buildProductCard(
                      "STAR Infobank 15",
                      "Saham",
                      "> 3 Tahun",
                      "-20,01%/Tahun",
                      Colors.red,
                    ),
                    SizedBox(height: 16.h),

                    // Produk 2: STAR Money Market Pasar Uang
                    _buildProductCard(
                      "STAR Money Market",
                      "Pasar Uang",
                      "< 1 Tahun",
                      "5,65%/Tahun",
                      Colors.green,
                    ),
                    SizedBox(height: 16.h),

                    // Produk 3: STAR Fixed Income Obligasi
                    _buildProductCard(
                      "STAR Fixed Income",
                      "Obligasi",
                      "1–3 Tahun",
                      "9,09%/Tahun",
                      Colors.green,
                    ),

                    SizedBox(height: 24.h),

                    // Disclaimer
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        "Setiap indikasi imbal hasil yang ditampilkan ini merupakan kinerja historis masa lalu dan tidak menjamin kinerja masa datang.",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Tombol Selanjutnya
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A1B9A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Navigasi ke halaman berikutnya
                        },
                        child: Text(
                          "Selanjutnya",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat kartu produk reksa dana
  Widget _buildProductCard(String title, String type, String period, String performance, Color performanceColor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul Produk dan Type
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                type,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Garis pemisah
          Divider(color: Colors.grey[300], height: 1.h),
          SizedBox(height: 12.h),

          // Periode Rekomendasi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Periode Rekomendasi",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                period,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Kinerja Historis
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kinerja Historis",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                performance,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: performanceColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Tombol Beli
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                "Beli",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
