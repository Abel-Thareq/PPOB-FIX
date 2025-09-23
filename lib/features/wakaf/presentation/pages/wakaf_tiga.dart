import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/wakaf/presentation/pages/wakaf_dua.dart';
import 'package:ppob_app/features/wakaf/presentation/pages/wakaf_empat.dart';
import 'wakaf_model.dart';

class WakafTigaPage extends StatelessWidget {
  final WakafModel wakaf;

  const WakafTigaPage({Key? key, required this.wakaf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const WakafDuaPage()),
          (route) => false,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // HEADER
            SizedBox(
              height: 140.h,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120.h,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/header.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 28.r),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const WakafDuaPage()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.w,
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
                          'Wakaf',
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

            // KONTEN UTAMA
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Program Wakaf
                    Text(
                      wakaf.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Garis pemisah
                    Container(
                      height: 1.h,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 16.h),

                    // Deskripsi Program
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: '${wakaf.subtitle}\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '${wakaf.quote}\n\n',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.deepPurple,
                            ),
                          ),
                          TextSpan(
                            text: wakaf.detailedDescription,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Tombol "Mulai Donasi"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman pilihan donasi
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WakafEmpatPage(wakaf: wakaf),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5938FB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          elevation: 2,
                        ),
                        child: Text(
                          wakaf.buttonText,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Informasi Tambahan - Manfaat Wakaf
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manfaat ${wakaf.title}:',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          ...wakaf.benefits.map((benefit) => _buildBenefitItem(benefit)),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 16.r, color: Colors.green),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}