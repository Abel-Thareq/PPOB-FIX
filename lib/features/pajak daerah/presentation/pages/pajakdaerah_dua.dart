import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/pajak%20daerah/presentation/pages/pajakdaerah_tiga.dart';

class PajakDaerahDuaPage extends StatefulWidget {
  final String provinceName;
  final String provinceImage;

  const PajakDaerahDuaPage({
    super.key,
    required this.provinceName,
    required this.provinceImage,
  });

  @override
  State<PajakDaerahDuaPage> createState() => _PajakDaerahDuaPageState();
}

class _PajakDaerahDuaPageState extends State<PajakDaerahDuaPage> {
  final TextEditingController _tagihanController = TextEditingController();
  String? _selectedCity;
  bool _isButtonEnabled = false;

  final List<String> _cities = [
    'Jakarta Pusat',
    'Jakarta Selatan',
    'Jakarta Barat',
    'Jakarta Timur',
    'Jakarta Utara',
  ];

  @override
  void initState() {
    super.initState();
    _tagihanController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _tagihanController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _selectedCity != null && _tagihanController.text.isNotEmpty;
    });
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  // Fungsi navigasi ke halaman ketiga
  void _navigateToPajakDaerahTigaPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PajakDaerahTigaPage(
          provinceName: widget.provinceName,
          provinceImage: widget.provinceImage,
          cityName: _selectedCity!,
          tagihanNumber: _tagihanController.text,
        ),
      ),
    );
  }

  void _showCityDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.h,
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Text(
                'Pilih Kota/Kabupaten',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: _cities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_cities[index]),
                      onTap: () {
                        setState(() {
                          _selectedCity = _cities[index];
                          _updateButtonState();
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double headerHeight = 120.h;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          navigateBack(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: headerHeight),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    // Header dengan logo provinsi
                    Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Image.asset(
                            widget.provinceImage,
                            width: 40.w,
                            height: 40.h,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.location_city,
                                color: Colors.grey[400],
                                size: 20.r,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          widget.provinceName,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24.h),
                    // Pilih Kota/Kabupaten
                    Text(
                      "Pilih Kota/Kabupaten",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6A1B9A),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () => _showCityDropdown(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6.r,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[400],
                              size: 20.r,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                _selectedCity ?? "Pilih Kota/Kabupaten",
                                style: TextStyle(
                                  color: _selectedCity != null ? Colors.black : Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Nomor Tagihan
                    Text(
                      "Nomor Tagihan",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6A1B9A),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6.r,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.grey[400],
                            size: 20.r,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: _tagihanController,
                              decoration: InputDecoration(
                                hintText: "Masukan Nomor Tagihan",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
            // Header background
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            // Tombol kembali
            Positioned(
              top: 50.h,
              left: 10.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28.r,
                onPressed: () {
                  navigateBack(context);
                },
              ),
            ),
          ],
        ),
        // Tombol Lanjutkan
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(24.w),
          child: ElevatedButton(
            onPressed: _isButtonEnabled ? () {
              _navigateToPajakDaerahTigaPage(context);
            } : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isButtonEnabled
                  ? const Color(0xFF6A1B9A)
                  : const Color(0xFFE0E0E0),
              foregroundColor: _isButtonEnabled
                  ? Colors.white
                  : Colors.grey[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              elevation: 0,
            ),
            child: Text(
              "Lanjutkan",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}