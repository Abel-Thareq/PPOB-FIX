import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/asuransi/presentation/pages/asuransi_page.dart';
import 'package:ppob_app/features/bpjs/presentation/pages/bpjs_page.dart';
import 'package:ppob_app/features/cicilan/presentation/pages/cicilan_page.dart';
import 'package:ppob_app/features/einvoicing/presentation/pages/einvoicing_page.dart';
import 'package:ppob_app/features/etilang/presentation/pages/etilang_page.dart';
import 'package:ppob_app/features/kabelinternet/presentation/pages/internet_page.dart';
import 'package:ppob_app/features/kai/presentation/pages/kai_page.dart';
import 'package:ppob_app/features/kartukredit/presentation/pages/kredit_page.dart';
import 'package:ppob_app/features/kua/presentation/pages/kua_page.dart';
import 'package:ppob_app/features/mpn/presentation/pages/mpn_page.dart';
import 'package:ppob_app/features/pajak%20daerah/presentation/pages/pajakdaerah_page.dart';
import 'package:ppob_app/features/pascabayar/presentation/pages/pascabayar_page.dart';
import 'package:ppob_app/features/paspor/presentation/pages/paspor_page.dart';
import 'package:ppob_app/features/pbb/presentation/pages/pbb_page.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/pgn/presentation/pages/pgn_page.dart';
import 'package:ppob_app/features/samsat/presentation/pages/samsat_page.dart';
import 'package:ppob_app/features/snpmb/presentation/pages/snpmb_page.dart';
import 'package:ppob_app/features/telkom/presentation/pages/telkom_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/pendidikan_page.dart';
import 'package:ppob_app/features/transaction/presentation/pages/properti1_page.dart';

class TagihanPage extends StatelessWidget {
  const TagihanPage({super.key});

  final List<Map<String, String>> menuItems = const [
    {'title': 'Briva', 'icon': 'assets/images/briva.png'},
    {'title': 'Listrik', 'icon': 'assets/images/listrik.png'},
    {'title': 'BPJS', 'icon': 'assets/images/bpjs.png'},
    {'title': 'Kartu Kredit', 'icon': 'assets/images/kartukredit.png'},
    {'title': 'Cicilan', 'icon': 'assets/images/cicilan.png'},
    {'title': 'KAI', 'icon': 'assets/images/kai.png'},
    {'title': 'PDAM', 'icon': 'assets/images/pdam.png'},
    {'title': 'Pendidikan', 'icon': 'assets/images/pendidikan.png'},
    {'title': 'Asuransi', 'icon': 'assets/images/asuransi.png'},
    {'title': 'PBB', 'icon': 'assets/images/pbb.png'},
    {'title': 'Pascabayar', 'icon': 'assets/images/pascabayar.png'},
    {'title': 'SNPMB', 'icon': 'assets/images/snpmb.png'},
    {'title': 'SAMSAT', 'icon': 'assets/images/samsat.png'},
    {'title': 'Telkom', 'icon': 'assets/images/telkom.png'},
    {'title': 'Bayar SPT Bulanan', 'icon': 'assets/images/spt.png'},
    {'title': 'Bayar KUA', 'icon': 'assets/images/kua.png'},
    {'title': 'E-Invoicing', 'icon': 'assets/images/einvoicing.png'},
    {'title': 'PGN', 'icon': 'assets/images/pgn.png'},
    {'title': 'E-Tilang', 'icon': 'assets/images/etilang.png'},
    {'title': 'Bayar Paspor', 'icon': 'assets/images/bayarpaspor.png'},
    {'title': 'TV Kabel & Internet', 'icon': 'assets/images/tvkabelinternet.png'},
    {'title': 'Pajak Daerah', 'icon': 'assets/images/pajakdaerah.png'},
    {'title': 'IPL & Properti', 'icon': 'assets/images/iplproperti.png'},
    {'title': 'Penerimaan Negara', 'icon': 'assets/images/penerimaannegara.png'},
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
      },
      child: Scaffold(
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
                      padding: EdgeInsets.only(top: 22.0, left: 16.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 28.r),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const MainScreen()),
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
                          'Daftar Tagihan & Bayar',
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
                padding: EdgeInsets.only(
                  top: 0.h,
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
                        mainAxisSpacing: 2.h,
                        childAspectRatio: 0.75,
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
            Expanded(
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
    if (title == 'BPJS') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BpjsPage()),
      );
    } else if (title == 'PBB') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PbbPage()),
      );
    } else if (title == 'TV Kabel & Internet') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InternetPage()),
      );
    } else if (title == 'Kartu Kredit') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KreditPage()),
      );
    } else if (title == 'Cicilan') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CicilanPage()),
      );
    } else if (title == 'SNPMB') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SnpmbPage()),
      );
    } else if (title == 'SAMSAT') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SamsatPage()),
      );
    } else if (title == 'Asuransi') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AsuransiPage()),
      );
    } else if (title == 'PGN') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PgnPage()),
      );
    } else if (title == 'KAI') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KaiPage()),
      );
    } else if (title == 'E-Invoicing') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EinvoicingPage()),
      );
    } else if (title == 'Telkom') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TelkomPage()),
      );
    } else if (title == 'Penerimaan Negara') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MpnPage()),
      );
    } else if (title == 'E-Tilang') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EtilangPage()),
      );
    } else if (title == 'Bayar KUA') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const KuaPage()),
      );
    } else if (title == 'Pascabayar') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PascabayarPage()),
      );
    } else if (title == 'Bayar Paspor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PasporPage()),
      );
    } else if (title == 'Pajak Daerah') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PajakDaerahPage()),
      );
    } else if (title == 'Pendidikan') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PendidikanPage()),
      );
    } else if (title == 'IPL & Properti') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Properti1Page()),
      );
    } else {
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
}
