import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/reksa_dana/presentation/pages/reksa_lima.dart';

class ReksaEmpatPage extends StatefulWidget {
  final String selectedProduct;

  const ReksaEmpatPage({Key? key, required this.selectedProduct}) : super(key: key);

  @override
  State<ReksaEmpatPage> createState() => _ReksaEmpatPageState();
}

class _ReksaEmpatPageState extends State<ReksaEmpatPage> {
  // Constants
  static const double minimumPembelian = 10000;
  static const double minValueChart = 1000.0;
  static const double maxValueChart = 1080.0;

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
          'increase': '5.65%',
          'performanceColor': Colors.green,
          'image': "assets/images/moneymarket.png",
        };
      case "STAR Infobank 15":
        return {
          'title': 'STAR Infobank 15',
          'value': '1.117,1539',
          'date': '10 Sep 2025',
          'profit': '-3.68%',
          'type': 'Saham',
          'risk': 'Tinggi',
          'manager': '\$305',
          'investmentReturn': 'Rp-200,100',
          'increase': '-20.01%',
          'performanceColor': Colors.red,
          'image': "assets/images/infobank.png",
        };
      case "STAR Fixed Income":
        return {
          'title': 'STAR Fixed Income',
          'value': '1.070,2009',
          'date': '10 Sep 2025',
          'profit': '6.1%',
          'type': 'Obligasi',
          'risk': 'Sedang',
          'manager': '\$275',
          'investmentReturn': 'Rp98.600',
          'increase': '9.86%',
          'performanceColor': Colors.green,
          'image': "assets/images/fixedincome.png",
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
          'increase': '5.65%',
          'performanceColor': Colors.green,
          'image': "assets/images/moneymarket.png",
        };
    }
  }

  // Data untuk grafik - berdasarkan gambar yang diberikan
  final List<Map<String, dynamic>> chartData = [
    {'date': '16 Apr', 'value': 1029.4587},
    {'date': 'Jan 25', 'value': 1000.0},
    {'date': 'Mar 25', 'value': 1040.0},
    {'date': 'Mei 25', 'value': 1060.0},
    {'date': 'Jul 25', 'value': 1080.0},
    {'date': '18 Sep', 'value': 1078.8743},
  ];

  int _selectedIndex = 5;
  int _selectedPeriodIndex = 0;
  DateTime _lastUpdate = DateTime.now();
  final TextEditingController _jumlahPembelianController = TextEditingController();

  @override
  void dispose() {
    _jumlahPembelianController.dispose();
    super.dispose();
  }

  void _updateSelectedIndex(int newIndex) {
    final now = DateTime.now();
    // Debouncing: hanya update setiap 16ms (~60 FPS)
    if (now.difference(_lastUpdate).inMilliseconds > 16) {
      if (newIndex != _selectedIndex) {
        setState(() {
          _selectedIndex = newIndex;
        });
        _lastUpdate = now;
      }
    }
  }

    void _showBuyBottomSheet(BuildContext context) {
    final data = productData;
    final double currentValue = double.parse(data['value'].replaceAll('.', '').replaceAll(',', '.')); // Ubah format nilai

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                double perkiraanUnit = 0;
                String jumlahPembelianText = _jumlahPembelianController.text;
                double jumlahPembelian = 0;

                // Validasi input
                if (jumlahPembelianText.isNotEmpty) {
                  jumlahPembelian = double.tryParse(jumlahPembelianText) ?? 0;
                  if (jumlahPembelian < 0) {
                    jumlahPembelian = 0;
                  }
                  if (jumlahPembelian >= minimumPembelian) {
                    perkiraanUnit = jumlahPembelian / currentValue; // Hitung perkiraan unit
                  }
                }

                return Container(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Beli Reksa Dana",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Image.asset(
                              data['image'],
                              width: 40.w,
                              height: 40.h,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['title'],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${data['value']} - ${data['date']}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Jumlah Pembelian",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _jumlahPembelianController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Rp0",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          errorText: jumlahPembelian < minimumPembelian && jumlahPembelian != 0
                              ? "Jumlah minimum pembelian Rp${minimumPembelian.toStringAsFixed(0)}"
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Jumlah minimum pembelian Rp${minimumPembelian.toStringAsFixed(0)}.",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Perkiraan Unit",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            perkiraanUnit.toStringAsFixed(4),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Icon(Icons.info_outline, size: 16.r, color: Colors.grey[600]),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              "Saya menyetujui Reksa Dana dan telah membaca serta mengerti Syarat & Ketentuan, Prospektus dan Fund Fact Sheet yang berlaku. Dengan membeli, saya juga memahami seluruh risiko keputusan investasi yang dibuat.",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
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
                          onPressed: jumlahPembelian >= minimumPembelian
                              ? () {
                                  // Navigasi ke ReksaLimaPage dengan data
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReksaLimaPage(
                                        productName: data['title'],
                                        productImage: data['image'],
                                        nominal: jumlahPembelian.toInt(), // Kirim nominal sebagai integer
                                        perkiraanUnit: perkiraanUnit,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          child: Text(
                            "Beli",
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
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = productData;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Tambahkan ini di sini
        body: Column(
          children: [
            // HEADER
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

                  // BOX "Detail Produk" melayang di bawah header
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
                    // Nama Produk, Nilai, dan Tanggal
                    Container(
                      width: double.infinity,
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

                    // Grafik Interaktif
                    Container(
                      height: 220.h,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          // Tanggal yang dipilih pada grafik
                          Text(
                            "${chartData[_selectedIndex]['date']} : Rp${chartData[_selectedIndex]['value'].toStringAsFixed(4).replaceAll('.', ',')}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 8.h),

                          // Grafik dengan sumbu Y
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Y-axis labels
                                Container(
                                  width: 40.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('1.080', style: TextStyle(fontSize: 10.sp)),
                                      Text('1.060', style: TextStyle(fontSize: 10.sp)),
                                      Text('1.040', style: TextStyle(fontSize: 10.sp)),
                                      Text('1.020', style: TextStyle(fontSize: 10.sp)),
                                      Text('1.000', style: TextStyle(fontSize: 10.sp)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),

                                // Grafik dengan Listener yang dioptimasi
                                Expanded(
                                  child: Listener(
                                    onPointerMove: (details) {
                                      final box = context.findRenderObject() as RenderBox?;
                                      if (box != null) {
                                        final localPosition = box.globalToLocal(details.position);
                                        final x = localPosition.dx;
                                        final width = box.size.width;

                                        if (x >= 0 && x <= width) {
                                          final newIndex = ((x / width) * (chartData.length - 1)).round().clamp(0, chartData.length - 1);
                                          _updateSelectedIndex(newIndex);
                                        }
                                      }
                                    },
                                    onPointerDown: (details) {
                                      final box = context.findRenderObject() as RenderBox?;
                                      if (box != null) {
                                        final localPosition = box.globalToLocal(details.position);
                                        final x = localPosition.dx;
                                        final width = box.size.width;
                                        final newIndex = ((x / width) * (chartData.length - 1)).round().clamp(0, chartData.length - 1);
                                        _updateSelectedIndex(newIndex);
                                      }
                                    },
                                    child: RepaintBoundary(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: CustomPaint(
                                          painter: _ChartPainter(
                                            data: chartData,
                                            selectedIndex: _selectedIndex,
                                            lineColor: Colors.deepPurple,
                                            pointColor: Colors.deepPurple[300]!,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Label tanggal di bawah grafik
                          Container(
                            height: 30.h,
                            padding: EdgeInsets.only(left: 48.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: chartData.map((point) {
                                return SizedBox(
                                  width: 40.w,
                                  child: Text(
                                    point['date'],
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tab Periode
                    Container(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 1 Bulan
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPeriodIndex = 0;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: _selectedPeriodIndex == 0 ? Colors.deepPurple : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: _selectedPeriodIndex == 0 ? Colors.deepPurple : Colors.grey[400]!,
                                  width: 1.r,
                                ),
                              ),
                              child: Text(
                                "1 Bulan",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedPeriodIndex == 0 ? Colors.white : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),

                          // 3 Bulan
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPeriodIndex = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: _selectedPeriodIndex == 1 ? Colors.deepPurple : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: _selectedPeriodIndex == 1 ? Colors.deepPurple : Colors.grey[400]!,
                                  width: 1.r,
                                ),
                              ),
                              child: Text(
                                "3 Bulan",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedPeriodIndex == 1 ? Colors.white : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),

                          // YTD
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPeriodIndex = 2;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: _selectedPeriodIndex == 2 ? Colors.deepPurple : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: _selectedPeriodIndex == 2 ? Colors.deepPurple : Colors.grey[400]!,
                                  width: 1.r,
                                ),
                              ),
                              child: Text(
                                "YTD",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedPeriodIndex == 2 ? Colors.white : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),

                          // 1 Tahun
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPeriodIndex = 3;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: _selectedPeriodIndex == 3 ? Colors.deepPurple : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: _selectedPeriodIndex == 3 ? Colors.deepPurple : Colors.grey[400]!,
                                  width: 1.r,
                                ),
                              ),
                              child: Text(
                                "1 Tahun",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedPeriodIndex == 3 ? Colors.white : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tabel Informasi dengan Box Ungu di Dalamnya
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Table(
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

                          // Box Ungu Transparan "Dikelola Oleh" dengan Logo STAR di dalam tabel
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.1),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Teks "Dikelola Oleh" - align kiri
                                Text(
                                  "Dikelola Oleh",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                // Logo STAR - align kanan
                                Image.asset(
                                  "assets/images/staram.png",
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Simulasi Investasi - DIUBAH agar sesuai gambar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Simulasi Investasi
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Simulasi Investasi",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // Konten Simulasi Investasi
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jika kamu investasi",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Rp1.000.000",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.h),

                                // Tabel Keuntungan
                                Container(
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
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Alokasi Aset - DIUBAH sesuai gambar
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Alokasi Aset
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                topRight: Radius.circular(8.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Alokasi Aset",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // Konten Alokasi Aset
                          Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Bar untuk Pasar Uang 100%
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                                                                Text(
                                          "Pasar Uang",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "100%",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: 1.0, // 100%
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 24.h),

                                // Prospektus dengan box sendiri
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.description_outlined, size: 20.r, color: Colors.deepPurple),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Prospektus",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                // Fund Fact Sheet dengan box sendiri
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.article_outlined, size: 20.r, color: Colors.deepPurple),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Fund Fact Sheet",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 16.h),

                                // Teks disclaimer
                                Text(
                                  "Setiap indikasi hasil yang ditampilkan ini merupakan kinerja historis masa lalu dan tidak mencerminkan kinerja masa datang.",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
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
                            _showBuyBottomSheet(context);
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

// Custom painter untuk menggambar grafik - DIOPTIMISASI
class _ChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final int selectedIndex;
  final Color lineColor;
  final Color pointColor;
  final List<Offset> points;

  // Inisialisasi Paint objects di luar fungsi paint
  final Paint _linePaint;
  final Paint _pointPaint;
  final Paint _selectedPaint;
  final Paint _gridPaint;

  _ChartPainter({
    required this.data,
    required this.selectedIndex,
    required this.lineColor,
    required this.pointColor,
  })  : points = _calculatePoints(data),
        _linePaint = Paint()
          ..color = lineColor
          ..strokeWidth = 3.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        _pointPaint = Paint()
          ..color = pointColor
          ..style = PaintingStyle.fill,
        _selectedPaint = Paint()
          ..color = Colors.deepPurple
          ..style = PaintingStyle.fill,
        _gridPaint = Paint()
          ..color = Colors.grey[300]!
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

  static List<Offset> _calculatePoints(List<Map<String, dynamic>> data) {
    final points = <Offset>[];
    final minValue = 1000.0;
    final maxValue = 1080.0;

    // Assume a fixed size for pre-calculation
    const width = 300.0;
    const height = 200.0;

    final xStep = width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * xStep;
      final normalizedValue = (data[i]['value'] - minValue) / (maxValue - minValue);
      final y = height - (normalizedValue * height);
      points.add(Offset(x, y));
    }
    return points;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw horizontal grid lines
    final double gridStep = size.height / 4;
    for (int i = 0; i <= 4; i++) {
      final y = i * gridStep;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), _gridPaint);
    }

    // Scale points to actual size
    final scaleX = size.width / 300;
    final scaleY = size.height / 200;
    final scaledPoints = points.map((point) => Offset(point.dx * scaleX, point.dy * scaleY)).toList();

    // Draw the line chart
    final path = Path();
    path.moveTo(scaledPoints[0].dx, scaledPoints[0].dy);

    for (int i = 1; i < scaledPoints.length; i++) {
      path.lineTo(scaledPoints[i].dx, scaledPoints[i].dy);
    }

    canvas.drawPath(path, _linePaint);

    // Draw points
    for (int i = 0; i < scaledPoints.length; i++) {
      if (i == selectedIndex) {
        // Selected point -
        canvas.drawCircle(scaledPoints[i], 8.0, _selectedPaint);
        canvas.drawCircle(scaledPoints[i], 4.0, Paint()..color = Colors.white); // Temporary Paint object - can be optimized further if needed
      } else {
        // Regular points
        canvas.drawCircle(scaledPoints[i], 5.0, _pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}