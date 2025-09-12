import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/pajak%20daerah/presentation/pages/pajakdaerah_dua.dart';

class PajakDaerahPage extends StatefulWidget {
  const PajakDaerahPage({super.key});

  @override
  State<PajakDaerahPage> createState() => _PajakDaerahPageState();
}

class _PajakDaerahPageState extends State<PajakDaerahPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allProvinces = [
    {'name': 'DKI Jakarta', 'image': 'assets/images/jakarta_logo.png'},
    {'name': 'Jawa Barat', 'image': 'assets/images/jawa_barat_logo.png'},
    {'name': 'Jawa Tengah', 'image': 'assets/images/jawa_tengah_logo.png'},
    {'name': 'DI Yogyakarta', 'image': 'assets/images/yogyakarta_logo.png'},
    {'name': 'Jawa Timur', 'image': 'assets/images/jawa_timur_logo.png'},
  ];
  List<Map<String, String>> _filteredProvinces = [];

  @override
  void initState() {
    super.initState();
    _filteredProvinces = _allProvinces;
  }

  void _filterProvinces(String query) {
    final filtered = _allProvinces.where((province) {
      final nameLower = province['name']!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredProvinces = filtered;
    });
  }

  void navigateToMainScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  // Fungsi navigasi ke halaman kedua
  void _navigateToPajakDaerahDuaPage(
      BuildContext context, String provinceName, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PajakDaerahDuaPage(
          provinceName: provinceName,
          provinceImage: imagePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double headerHeight = 120.h;

    return PopScope(
      canPop: false, // mencegah pop default
      onPopInvoked: (didPop) {
        if (!didPop) {
          navigateToMainScreen(context); // arahkan ke MainScreen
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
                    Text(
                      "Pilih Provinsi",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                          Icon(Icons.search, color: Colors.grey[400]),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: _filterProvinces,
                              decoration: InputDecoration(
                                hintText: "Cari provinsi disini",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Daftar Provinsi",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
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
                      child: Column(
                        children: _buildProvinceList(context),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 50.h,
              left: 10.w,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28.r,
                onPressed: () {
                  navigateToMainScreen(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProvinceList(BuildContext context) {
    final List<Widget> items = [];

    for (int i = 0; i < _filteredProvinces.length; i++) {
      final province = _filteredProvinces[i];

      items.add(
        GestureDetector(
          onTap: () {
            _navigateToPajakDaerahDuaPage(
                context, province['name']!, province['image']!);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.asset(
                    province['image']!,
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
                Expanded(
                  child: Text(
                    province['name']!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      );

      if (i < _filteredProvinces.length - 1) {
        items.add(
          Divider(
            color: Colors.grey[300],
            height: 1.h,
            indent: 16.w,
            endIndent: 16.w,
          ),
        );
      }
    }

    return items;
  }
}
