import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/home/presentation/pages/lainnyahome_page.dart';
import 'package:ppob_app/features/reksa_dana/presentation/pages/reksa_empat.dart';

class ReksaTigaPage extends StatefulWidget {
  const ReksaTigaPage({super.key});

  @override
  State<ReksaTigaPage> createState() => _ReksaTigaPageState();
}

class _ReksaTigaPageState extends State<ReksaTigaPage> {
  // Function untuk handle back button
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LainnyaPage()), // Ganti ke LainnyaPage
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed(); // Panggil function back button
      },
      child: Scaffold(
        body: Column(
          children: [
            // HEADER - Tinggi ditingkatkan agar kotak bisa turun
            SizedBox(
              height: 220.h, // Tinggi diubah dari 200.h menjadi 220.h
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

                  // Tombol back
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 28.r),
                        color: Colors.white,
                        onPressed: _onBackPressed, // Gunakan function yang sama
                      ),
                    ),
                  ),

                  // BOX slogan
                  Positioned(
                    bottom: 80.h, // Posisi diturunkan dari 70.h
                    left: 24.w,
                    right: 24.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
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

                  // BOX TOTAL INVESTASI (revisi: lebih kecil & dipisah)
                  Positioned(
                    bottom: 10.h, // Posisi diturunkan dari 0
                    left: 24.w,
                    right: 24.w,
                    child: Container(
                      padding: EdgeInsets.all(8.w), // jarak bezel putih
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Ungu solid
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Investasi",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Rp0",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.visibility_off,
                                    color: Colors.white, size: 18.r),
                              ],
                            ),
                          ),

                          SizedBox(height: 8.h), // jarak putih antar kotak

                          // Ungu transparan
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Keuntungan",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black87),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Rp0",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Total Kenaikan",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black87),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "0%",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
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
                child: Column(
                  children: [
                    // Jarak tambahan untuk menurunkan content box
                    SizedBox(height: 10.h),
                    // Kotak abu-abu yang sekarang full-width
                    _buildSectionBoxFullWidth("PILIH PRODUK REKSADANA"),
                    // Tambahkan padding hanya untuk konten di bawahnya
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        top: 16.h,
                        bottom: 24.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProductCard(
                            "STAR Infobank 15",
                            "Saham",
                            "> 3 Tahun",
                            "-20,01%/Tahun",
                            Colors.red,
                            "assets/images/infobank.png", // icon produk
                          ),
                          _buildProductCard(
                            "STAR Money Market",
                            "Pasar Uang",
                            "< 1 Tahun",
                            "5,65%/Tahun",
                            Colors.green,
                            "assets/images/moneymarket.png",
                          ),
                          _buildProductCard(
                            "STAR Fixed Income",
                            "Obligasi",
                            "1–3 Tahun",
                            "9,09%/Tahun",
                            Colors.green,
                            "assets/images/fixedincome.png",
                          ),

                          SizedBox(height: 24.h),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat section title dalam kotak abu-abu FULL WIDTH
  Widget _buildSectionBoxFullWidth(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.zero,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Widget kartu produk
  // 🔹 Widget kartu produk (versi baru sesuai desain screenshot)
  Widget _buildProductCard(
    String title,
    String type,
    String period,
    String performance,
    Color performanceColor,
    String iconPath,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        // MENAMBAHKAN EFEK SHADOW YANG LEBIH TERLIHAT
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10.r,
            spreadRadius: 2.r, // Menambahkan spreadRadius untuk membuat bayangan menyebar lebih jauh
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header: Icon + Nama Produk + Jenis
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent, // 🔹 transparan, tidak ada background ungu
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      iconPath,
                      fit: BoxFit.contain, // 🔹 biar full keliatan, gak ketutupan
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Box ungu transparan
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Periode Rekomendasi",
                      style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Kinerja Historis",
                      style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                    ),
                    SizedBox(height: 2.h),
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
              ],
            ),
          ),

          SizedBox(height: 7.h),

          // 🔹 Tombol Beli full width di bawah
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Center(
              child: SizedBox(
                height: 40.h,
                width: 280.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReksaEmpatPage(selectedProduct: title),
                      ),
                    );
                  },
                  child: Text(
                    "Beli",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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