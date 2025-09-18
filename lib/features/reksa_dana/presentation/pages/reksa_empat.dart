import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/home/presentation/pages/tagihan_page.dart';

class ReksaEmpatPage extends StatefulWidget {
  final String selectedProduct;
  
  const ReksaEmpatPage({super.key, required this.selectedProduct});

  @override
  State<ReksaEmpatPage> createState() => _ReksaEmpatPageState();
}

class _ReksaEmpatPageState extends State<ReksaEmpatPage> {
  // Data produk berdasarkan pilihan
  Map<String, dynamic> get productData {
    switch (widget.selectedProduct) {
      case "STAR Money Market":
        return {
          'title': 'STAR Money Market',
          'value': '1.117,1539',
          'date': '10 Sep 2025',
          'profit': '3.88%',
          'type': 'Pasar Uang',
          'risk': 'Rendah',
          'manager': '\$288',
          'investmentReturn': 'Rp56.500',
          'increase': '5.86%',
          'icon': 'assets/images/moneymarket.png',
          'performanceColor': Colors.green,
        };
      case "STAR Infobank 15":
        return {
          'title': 'STAR Infobank 15',
          'value': '1.205,4321',
          'date': '10 Sep 2025',
          'profit': '-20.01%',
          'type': 'Saham',
          'risk': 'Tinggi',
          'manager': '\$305',
          'investmentReturn': 'Rp-200,100',
          'increase': '-20.01%',
          'icon': 'assets/images/infobank.png',
          'performanceColor': Colors.red,
        };
      case "STAR Fixed Income":
        return {
          'title': 'STAR Fixed Income',
          'value': '1.309,8765',
          'date': '10 Sep 2025',
          'profit': '9.09%',
          'type': 'Obligasi',
          'risk': 'Sedang',
          'manager': '\$275',
          'investmentReturn': 'Rp90,900',
          'increase': '9.09%',
          'icon': 'assets/images/fixedincome.png',
          'performanceColor': Colors.green,
        };
      default:
        return {
          'title': 'STAR Money Market',
          'value': '1.117,1539',
          'date': '10 Sep 2025',
          'profit': '3.88%',
          'type': 'Pasar Uang',
          'risk': 'Rendah',
          'manager': '\$288',
          'investmentReturn': 'Rp56.500',
          'increase': '5.86%',
          'icon': 'assets/images/moneymarket.png',
          'performanceColor': Colors.green,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final data = productData;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(
          children: [
            // HEADER - DIPERBAIKI sesuai referensi
            SizedBox(
              height: 140.h,
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                  // BOX "Detail Produk" melayang di bawah header (sama seperti desain)
                  Positioned(
                    bottom: 0,
                    left: 24.w,
                    right: 24.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey[300]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6.r,
                            offset: Offset(0, 3.h),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Detail Produk',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // KONTEN UTAMA
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 24.h,
                  bottom: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Produk, Nilai, dan Tanggal - DIPERBAIKI sesuai gambar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Nama Produk (tengah)
                          Text(
                            data['title'],
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          
                          // Nilai Produk (tengah)
                          Text(
                            data['value'],
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          
                          // Tanggal (tengah)
                          Text(
                            data['date'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Tab Periode
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "1 Bulan",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "3 Bulan",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "YTD",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "1 Tahun",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tabel Informasi
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Text(
                                  "Keuntungan",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Text(
                                  "Jenis Produk",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Text(
                                  "Risiko",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Text(
                                  data['profit'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: data['performanceColor'],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Text(
                                  data['type'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Text(
                                  data['risk'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Dikelola Oleh
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Text(
                            "Dikelola Oleh",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            data['manager'],
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Simulasi Investasi
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Simulasi Investasi",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Jika kamu investasi",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "Rp1.000.000",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Text(
                                        "Periode",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Text(
                                        "Keuntungan",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Text(
                                        "Kenaikan",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Text(
                                        "1 Tahun",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Text(
                                        data['investmentReturn'],
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: data['performanceColor'],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Text(
                                        data['increase'],
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: data['performanceColor'],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
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

                    SizedBox(height: 24.h),

                    // Alokasi Aset
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alokasi Aset",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Icon(Icons.check_box_outlined,
                                  size: 20.r, color: Colors.deepPurple),
                              SizedBox(width: 8.w),
                              Text(
                                "${data['type']} 100%",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.check_box_outline_blank,
                                  size: 20.r, color: Colors.grey),
                              SizedBox(width: 8.w),
                              Text(
                                "Prospektus",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(Icons.check_box_outline_blank,
                                  size: 20.r, color: Colors.grey),
                              SizedBox(width: 8.w),
                              Text(
                                "Fund Fact Sheet",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Setiap indikasi hasil yang ditampilkan ini merupakan kinerja historis masa lalu dan tidak menjamin kinerja masa datang.",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Tombol Beli Sekarang
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: SizedBox(
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
                            // TODO: Aksi beli produk
                          },
                          child: Text(
                            "Beli Sekarang",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}