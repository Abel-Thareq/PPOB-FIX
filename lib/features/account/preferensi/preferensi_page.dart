import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreferensiPage extends StatelessWidget {
  const PreferensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Header dengan box "Preferensi"
          SizedBox(
            height: 140.h,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 28.r, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
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
                    ),
                    child: Center(
                      child: Text(
                        'Preferensi',
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

          // 🔹 Konten utama Preferensi
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ukuran Tulisan
                  Text(
                    "Ukuran Tulisan",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSizeButton("Medium", context),
                      _buildSizeButton("Besar", context),
                      _buildSizeButton("Sangat Besar", context),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Slider(
                    value: 1,
                    min: 0,
                    max: 2,
                    divisions: 2,
                    activeColor: const Color(0xFF5938FB),
                    onChanged: (val) {},
                  ),

                  SizedBox(height: 20.h),

                  // Jenis Font
                  Text(
                    "Jenis Font",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Column(
                    children: [
                      RadioListTile(
                        value: "Metropolis",
                        groupValue: "Metropolis",
                        onChanged: (_) {},
                        activeColor: const Color(0xFF5938FB),
                        title: Text("Metropolis"),
                      ),
                      RadioListTile(
                        value: "Varela",
                        groupValue: "",
                        onChanged: (_) {},
                        activeColor: const Color(0xFF5938FB),
                        title: Text("Varela"),
                      ),
                      RadioListTile(
                        value: "Captura",
                        groupValue: "",
                        onChanged: (_) {},
                        activeColor: const Color(0xFF5938FB),
                        title: Text("Captura"),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Pertinjau Teks
                  Text(
                    "Pertinjau Teks",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      "Selamat Datang di Modipay",
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Tombol Simpan
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5938FB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 40.w,
                        ),
                      ),
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeButton(String label, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF5938FB),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            "Aa",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(label),
      ],
    );
  }
}