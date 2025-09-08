import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ✅ import semua page e-wallet
import 'package:ppob_app/features/ewallet/linkaja/linkaja_page.dart';
import 'package:ppob_app/features/ewallet/ovo/ovo_page.dart';
import 'package:ppob_app/features/ewallet/shopeepay/shopeepay_page.dart';
import 'package:ppob_app/features/ewallet/dana/dana_page.dart';
import 'package:ppob_app/features/ewallet/isaku/isaku_page.dart';
import 'package:ppob_app/features/ewallet/gopay/gopay_page.dart';

class EwalletPage extends StatelessWidget {
  const EwalletPage({super.key});

  final List<Map<String, String>> ewalletItems = const [
    {'title': 'LinkAja', 'icon': 'assets/images/linkaja.png'},
    {'title': 'OVO', 'icon': 'assets/images/ovo.png'},
    {'title': 'ShopeePay', 'icon': 'assets/images/shopeepay.png'},
    {'title': 'DANA', 'icon': 'assets/images/dana.png'},
    {'title': 'i.saku', 'icon': 'assets/images/isaku.png'},
    {'title': 'Gopay', 'icon': 'assets/images/gopay.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Header
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
                        'Pilih E Wallet',
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

          // 🔹 Grid item e-wallet
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 20.h,
                  childAspectRatio: 0.8,
                ),
                itemCount: ewalletItems.length,
                itemBuilder: (context, index) {
                  return _buildWalletItem(context, ewalletItems[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletItem(BuildContext context, Map<String, String> item) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () => _handleWalletTap(context, item['title']!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: EdgeInsets.all(10.r),
            child: Image.asset(
              item['icon']!,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.account_balance_wallet,
                size: 32.w,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            item['title']!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _handleWalletTap(BuildContext context, String title) {
    switch (title) {
      case "LinkAja":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const LinkAjaPage()));
        break;
      case "OVO":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const OvoPage()));
        break;
      case "ShopeePay":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ShopeePayPage()));
        break;
      case "DANA":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DanaPage()));
        break;
      case "i.saku":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const IsakuPage()));
        break;
      case "Gopay":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const GopayPage()));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: $title')),
        );
    }
  }
}