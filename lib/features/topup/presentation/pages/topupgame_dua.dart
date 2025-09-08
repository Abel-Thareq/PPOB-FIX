import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'topupgame_tiga.dart'; // Import halaman TopUpGameTiga

class TopUpGameDua extends StatelessWidget {
  final String gameTitle;
  final dynamic gameIcon; // Diubah dari IconData menjadi dynamic
  final String gameId;
  final String serverId;
  final String selectedDiamond;
  final String diamondImagePath;
  final String price;

  const TopUpGameDua({
    super.key,
    required this.gameTitle,
    required this.gameIcon,
    required this.gameId,
    required this.serverId,
    required this.selectedDiamond,
    required this.diamondImagePath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    final double horizontalPadding = 24.w;

    // Menentukan widget ikon yang akan ditampilkan berdasarkan tipe data
    Widget displayIconWidget;
    if (gameIcon is IconData) {
      displayIconWidget = Icon(gameIcon, size: 40.r);
    } else if (gameIcon is String) {
      displayIconWidget = Image.asset(gameIcon, width: 40.r, height: 40.r);
    } else {
      displayIconWidget = const SizedBox.shrink(); // Fallback jika tidak ada ikon
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100.h,
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
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          // Konten halaman
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sumber Dana',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5938FB),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF5938FB),
                      child: Text(
                        'AT',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                    title: Text(
                      'ABEL THAREQ',
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'modipay - 081215633163',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    ),
                  ),
                  Divider(height: 1.h, thickness: 1),
                  SizedBox(height: 16.h),

                  Text(
                    'Tujuan',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5938FB),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ListTile(
                    leading: displayIconWidget, // Menggunakan widget ikon yang sudah ditentukan
                    title: Text(
                      gameTitle,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '$gameId ($serverId)',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(height: 7.h),

                  // Box untuk "Tambah Ke Daftar Tersimpan"
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tambah Ke Daftar Tersimpan',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Switch(
                          value: true,
                          onChanged: (bool value) {
                            // Handle switch state change
                          },
                          activeColor: const Color(0xFF5938FB),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Divider(height: 1.h, thickness: 1), // Garis di atas "Produk"
                  SizedBox(height: 16.h),

                  Text(
                    'Produk',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5938FB),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nominal',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                      ),
                      Text(
                        selectedDiamond,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp$price',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(height: 1.h, thickness: 1), // Garis di bawah "Produk"
                ],
              ),
            ),
          ),
          // Tombol Konfirmasi
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.h),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi untuk navigasi ke halaman TopUpGameTiga dan mengirim data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpGameTiga(
                        gameTitle: gameTitle,
                        gameId: gameId,
                        serverId: serverId,
                        selectedDiamond: selectedDiamond,
                        price: price,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5938FB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 0,
                ),
                child: Text(
                  'Konfirmasi',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
