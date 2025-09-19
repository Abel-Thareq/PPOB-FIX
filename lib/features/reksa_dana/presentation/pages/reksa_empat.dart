import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          'performanceColor': Colors.red,
        };
      case "STAR Fixed Income":
        return {
          'title': 'STAR Fixed Income',
          'value': '1.078,8743',
          'date': '18 Sep 2025',
          'profit': '6.96%',
          'type': 'Obligasi',
          'risk': 'Sedang',
          'manager': '\$275',
          'investmentReturn': 'Rp98.600',
          'increase': '9.86%',
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
          'performanceColor': Colors.green,
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
  int _selectedPeriodIndex = 0; // Added for period tabs selection

  @override
  void initState() {
    super.initState();
    // Hapus ScreenUtil.init dari sini
  }

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ScreenUtil di sini - PERBAIKAN UTAMA
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
                                
                                // Grafik
                                Expanded(
                                  child: GestureDetector(
                                    onHorizontalDragUpdate: (details) {
                                      final RenderBox box = context.findRenderObject() as RenderBox;
                                      final Offset localOffset = box.globalToLocal(details.globalPosition);
                                      final double x = localOffset.dx;
                                      final double width = box.size.width;
                                      
                                      if (x >= 0 && x <= width) {
                                        final newIndex = ((x / width) * (chartData.length - 1)).round().clamp(0, chartData.length - 1);
                                        setState(() {
                                          _selectedIndex = newIndex;
                                        });
                                      }
                                    },
                                    onTapDown: (details) {
                                      final RenderBox box = context.findRenderObject() as RenderBox;
                                      final double x = details.localPosition.dx;
                                      final double width = box.size.width;
                                      final newIndex = ((x / width) * (chartData.length - 1)).round().clamp(0, chartData.length - 1);

                                      setState(() {
                                        _selectedIndex = newIndex;
                                      });
                                    },
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
                              ],
                            ),
                          ),
                          
                          // Label tanggal di bawah grafik
                          Container(
                            height: 30.h,
                            padding: EdgeInsets.only(left: 48.w), // Match the chart offset
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: chartData.map((point) {
                                return SizedBox(
                                  width: 40.w, // Fixed width for each label
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

                    // Tab Periode - REDUCED SPACING
                    Container(
                      padding: EdgeInsets.only(top: 8.h, bottom: 8.h), // Reduced vertical padding
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Logo STAR
                                Image.asset(
                                  "assets/images/staram.png",
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                SizedBox(width: 12.w),
                                // Teks "Dikelola Oleh"
                                Text(
                                  "Dikelola Oleh",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                // Nama Manager
                                Text(
                                  data['manager'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
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

// Custom painter untuk menggambar grafik - DIPERBAIKI
class _ChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  final int selectedIndex;
  final Color lineColor;
  final Color pointColor;

  _ChartPainter({
    required this.data,
    required this.selectedIndex,
    required this.lineColor,
    required this.pointColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = pointColor
      ..style = PaintingStyle.fill;

    final selectedPaint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw horizontal grid lines
    final double gridStep = size.height / 4;
    for (int i = 0; i <= 4; i++) {
      final y = i * gridStep;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Find min and max values for scaling
    double minValue = 1000.0; // Based on the image
    double maxValue = 1080.0; // Based on the image

    // Calculate positions for each point
    final points = <Offset>[];
    final xStep = size.width / (data.length - 1);
    
    for (int i = 0; i < data.length; i++) {
      final x = i * xStep;
      final normalizedValue = (data[i]['value'] - minValue) / (maxValue - minValue);
      final y = size.height - (normalizedValue * size.height);
      points.add(Offset(x, y));
    }

    // Draw the line chart
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw points
    for (int i = 0; i < points.length; i++) {
      if (i == selectedIndex) {
        // Selected point - larger
        canvas.drawCircle(points[i], 8.0, selectedPaint);
        canvas.drawCircle(points[i], 4.0, Paint()..color = Colors.white);
      } else {
        // Regular points
        canvas.drawCircle(points[i], 5.0, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}