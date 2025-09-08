import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LainnyaPage extends StatelessWidget {
  const LainnyaPage({super.key});

  final List<Map<String, String>> menuItems = const [
    {'title': 'Top Up Game', 'icon': 'assets/images/game.png'},
    {'title': 'E-Voucher', 'icon': 'assets/images/voucher.png'},
    {'title': 'CGV Movies', 'icon': 'assets/images/movie.png'},
    {'title': 'Tiket Event & Hiburan', 'icon': 'assets/images/ticket.png'},
    {'title': 'Emas', 'icon': 'assets/images/gold.png'},
    {'title': 'Donasi', 'icon': 'assets/images/donation.png'},
    {'title': 'Zakat', 'icon': 'assets/images/zakat.png'},
    {'title': 'Wakaf', 'icon': 'assets/images/wakaf.png'},
    {'title': 'Fidyah', 'icon': 'assets/images/fidyah.png'},
    {'title': 'Bayar Ecommerce', 'icon': 'assets/images/ecommerce.png'},
    {'title': 'Investasi Pintar', 'icon': 'assets/images/investment.png'},
    {'title': 'Reksa Dana', 'icon': 'assets/images/mutual_fund.png'},
    {'title': 'Sedekah Santuni Anak Yatim', 'icon': 'assets/images/charity.png'},
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      body: Column(
        children: [
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
                      onPressed: () => Navigator.pop(context),
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
                        'Daftar Hiburan & Keuangan',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5938FB),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 12.h,
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
              ),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.75, // ✅ dibuat lebih tinggi
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return _buildMenuItem(context, menuItems[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, String> item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () => _handleMenuTap(context, item['title']!),
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              padding: EdgeInsets.all(2.r),
              child: Center(
                child: Image.asset(
                  item['icon']!,
                  width: 80.w,
                  height: 80.w,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.credit_card,
                    size: 32.w,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded( // ✅ supaya teks tidak overflow
              child: Text(
                item['title']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $title'),
        duration: const Duration(milliseconds: 300),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
