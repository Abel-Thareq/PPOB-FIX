import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/emoney/presentation/pages/bnitapcash_satu.dart';
import 'package:ppob_app/features/emoney/presentation/pages/brizzi_satu.dart';
import 'package:ppob_app/features/emoney/presentation/pages/flazz_bca_satu.dart';
import 'package:ppob_app/features/emoney/presentation/pages/mandiri_emoney_satu.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class EMoneyPage extends StatelessWidget {
  const EMoneyPage({super.key});

  final List<Map<String, dynamic>> emoneyItems = const [
    {'title': 'BRIZZI', 'image': 'assets/images/brizzi.png'},
    {'title': 'BNI TapCash', 'image': 'assets/images/bnitapcash.png'},
    {'title': 'Mandiri e-Money', 'image': 'assets/images/mandiriemoney.png'},
    {'title': 'Flazz BCA', 'image': 'assets/images/flazz.png'},
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    // PopScope untuk menangani tombol kembali fisik Android
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
              (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        color: Colors.white,
                        onPressed: () {
                          // Tombol kembali UI
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainScreen()),
                                (Route<dynamic> route) => false,
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
                          'Pilih E Money',
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
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: emoneyItems.length,
                  itemBuilder: (context, index) {
                    final item = emoneyItems[index];
                    VoidCallback? onTap;

                    switch (item['title']) {
                      case 'BRIZZI':
                        onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BrizziSatuPage()),
                          );
                        };
                        break;
                      case 'BNI TapCash':
                        onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BniTapCashSatuPage()),
                          );
                        };
                        break;
                      case 'Mandiri e-Money':
                        onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MandiriEmoneySatuPage()),
                          );
                        };
                        break;
                      case 'Flazz BCA':
                        onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FlazzBcaSatuPage()),
                          );
                        };
                        break;
                      default:
                        onTap = null;
                        break;
                    }

                    return _buildEMoneyItem(item, onTap);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEMoneyItem(Map<String, dynamic> item, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Center(
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item['title']!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}