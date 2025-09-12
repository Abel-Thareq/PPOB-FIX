import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class DonasiDuaPage extends StatefulWidget {
  const DonasiDuaPage({super.key});

  @override
  State<DonasiDuaPage> createState() => _DonasiDuaPageState();
}

class _DonasiDuaPageState extends State<DonasiDuaPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allInstitutions = [
    {'name': 'Rumah Zakat', 'image': 'assets/images/rumah_zakat_logo.png'},
    {'name': 'Rumah Yatim', 'image': 'assets/images/rumah_yatim_logo.png'},
    {'name': 'Rumah Wakaf', 'image': 'assets/images/rumah_wakaf_logo.png'},
    {'name': 'Wakaf Salman', 'image': 'assets/images/wakaf_salman_logo.png'},
    {'name': 'LAZ Al-Azhar', 'image': 'assets/images/laz_alazhar_logo.png'},
    {'name': 'DT Peduli', 'image': 'assets/images/dt_peduli_logo.png'},
    {'name': 'Palang Merah Remaja (PMI)', 'image': 'assets/images/pmi_logo.png'},
    {'name': 'Human Initiative', 'image': 'assets/images/human_initiative_logo.png'},
    {'name': 'Lazis Darul Hikam', 'image': 'assets/images/lazis_darul_hikam_logo.png'},
    {'name': 'Yayasan Dana Sosial Priangan', 'image': 'assets/images/ydsp_logo.png'},
    {'name': 'BAZNAS Jawa Barat', 'image': 'assets/images/baznas_jabar_logo.png'},
  ];
  List<Map<String, String>> _filteredInstitutions = [];

  @override
  void initState() {
    super.initState();
    _filteredInstitutions = _allInstitutions;
  }

  void _filterInstitutions(String query) {
    final filtered = _allInstitutions.where((institution) {
      final nameLower = institution['name']!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredInstitutions = filtered;
    });
  }

  void navigateToMainScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  // Fungsi navigasi ke halaman berikutnya (bisa disesuaikan)
  void _navigateToNextPage(BuildContext context, String institutionName, String imagePath) {
    // TODO: Implementasi navigasi ke halaman berikutnya
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => NextPage(
    //       institutionName: institutionName,
    //       institutionImage: imagePath,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double headerHeight = 120.h;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          navigateToMainScreen(context);
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
                      "Pilih Lembaga/Yayasan",
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
                              onChanged: _filterInstitutions,
                              decoration: InputDecoration(
                                hintText: "Cari lembaga/yayasan disini",
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
                      "Daftar Lembaga/Yayasan",
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
                        children: _buildInstitutionList(context),
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

  List<Widget> _buildInstitutionList(BuildContext context) {
    final List<Widget> items = [];

    for (int i = 0; i < _filteredInstitutions.length; i++) {
      final institution = _filteredInstitutions[i];

      items.add(
        GestureDetector(
          onTap: () {
            _navigateToNextPage(
                context, institution['name']!, institution['image']!);
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
                    institution['image']!,
                    width: 40.w,
                    height: 40.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.account_balance,
                        color: Colors.grey[400],
                        size: 20.r,
                      );
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    institution['name']!,
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

      if (i < _filteredInstitutions.length - 1) {
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