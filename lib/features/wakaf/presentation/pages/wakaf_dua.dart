import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/home/presentation/pages/lainnyahome_page.dart';
import 'wakaf_tiga.dart';
import 'wakaf_model.dart';

class WakafDuaPage extends StatelessWidget {
  const WakafDuaPage({super.key});

  // ---------- DATA WAKAF ---------- //
  final List<WakafModel> wakafList = const [
    WakafModel(
      id: 'alquran',
      title: 'Wakaf Al-Qur\'an',
      subtitle: 'Membangun Warisan Ilmu dengan Wakaf Al-Qur\'an bersama LinkAja & LinkAja Syariah',
      description: 'Wakaf Al-Qur\'an adalah program wakaf yang bertujuan untuk menyediakan mushaf Al-Qur\'an bagi masyarakat yang membutuhkan.',
      quote: '"Wakaf Al-Qur\'an, Sebarkan Cahaya Ilmu dan Kebajikan".',
      detailedDescription: 'Setiap wakaf Al-Qur\'an Anda adalah investasi untuk menyebarkan petunjuk dan hikmah bagi umat. Mari wujudkan semangat cinta Al-Qur\'an dan berikan kesempatan bagi banyak orang untuk mengenalnya.',
      benefits: [
        'Menyediakan mushaf Al-Qur\'an untuk masjid dan mushola',
        'Mendukung program tahfiz dan pendidikan Quran',
        'Distribusi ke daerah terpencil dan pelosok',
        'Meningkatkan akses baca Quran bagi masyarakat',
      ],
    ),
    WakafModel(
      id: 'pesantren',
      title: 'Wakaf Pesantren',
      subtitle: 'Wakaf Pesantren, Membangun Generasi Berkualitas',
      description: 'Wakaf Pesantren bertujuan untuk mendukung pengembangan dan operasional pesantren.',
      quote: '"Wakaf Pesantren, Cetak Generasi Qur\'ani yang Berakhlak Mulia".',
      detailedDescription: 'Dukung pendidikan Islam melalui wakaf pesantren. Setiap kontribusi Anda membantu mencetak generasi yang memahami dan mengamalkan nilai-nilai Quran dalam kehidupan sehari-hari.',
      benefits: [
        'Pembangunan infrastruktur pesantren',
        'Beasiswa untuk santri tidak mampu',
        'Pengembangan kurikulum dan fasilitas',
        'Dukungan operasional harian pesantren',
      ],
    ),
    WakafModel(
      id: 'produktif',
      title: 'Wakaf Produktif',
      subtitle: 'Wakaf Produktif, Investasi untuk Masa Depan Umat yang Berkelanjutan',
      description: 'Wakaf Produktif adalah wakaf yang dikelola secara produktif untuk kemaslahatan umat.',
      quote: '"Wakaf Produktif, Menciptakan Kemakmuran yang Berkelanjutan".',
      detailedDescription: 'Wakaf produktif menciptakan siklus ekonomi yang berkelanjutan. Hasil pengelolaan wakaf digunakan untuk memberdayakan ekonomi umat dan program sosial lainnya.',
      benefits: [
        'Pengembangan usaha produktif umat',
        'Pemberdayaan ekonomi masyarakat',
        'Hasil digunakan untuk program sosial',
        'Berkesinambungan dan sustainable',
      ],
    ),
    WakafModel(
      id: 'sumber_air',
      title: 'Wakaf Sumber Air Bersih',
      subtitle: 'Wakaf Air Bersih, Memberikan Kehidupan yang Berkualitas',
      description: 'Program wakaf untuk menyediakan akses air bersih bagi masyarakat yang membutuhkan.',
      quote: '"Wakaf Air, Sumber Kehidupan dan Kebersihan".',
      detailedDescription: 'Air bersih adalah kebutuhan dasar manusia. Dengan wakaf sumber air bersih, Anda membantu masyarakat yang kesulitan mendapatkan akses air bersih untuk kehidupan sehari-hari.',
      benefits: [
        'Pembangunan sumur dan sumber air bersih',
        'Instalasi penyaringan air',
        'Distribusi ke daerah rawan air bersih',
        'Program sanitasi dan kesehatan masyarakat',
      ],
    ),
    WakafModel(
      id: 'uang',
      title: 'Wakaf Uang',
      subtitle: 'Wakaf Uang untuk Investasi Jariyah',
      description: 'Wakaf Uang adalah wakaf yang dilakukan dalam bentuk tunai untuk dikelola secara profesional.',
      quote: '"Wakaf Uang, Investasi Akhirat yang Praktis".',
      detailedDescription: 'Wakaf uang memberikan fleksibilitas dalam pengelolaan. Dana wakaf akan dikelola secara profesional dan hasilnya digunakan untuk berbagai program wakaf yang dibutuhkan.',
      benefits: [
        'Fleksibel dan mudah dilakukan',
        'Dikelola secara profesional',
        'Hasil digunakan untuk berbagai program wakaf',
        'Transparan dan terawasi',
      ],
    ),
  ];

  // ---------- NAVIGASI KE HALAMAN DETAIL ---------- //
  void _navigateToWakafDetail(BuildContext context, WakafModel wakaf) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WakafTigaPage(wakaf: wakaf)),
    );
  }

  // ---------- BUILD MAIN PAGE ---------- //
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LainnyaPage()),
          (route) => false,
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            // HEADER dengan balok putih berisi "Wakaf"
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
                            MaterialPageRoute(builder: (_) => const LainnyaPage()),
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

            // KONTEN WAKAF
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // List Item Wakaf
                    ...wakafList.map((wakaf) => Column(
                      children: [
                        _buildWakafButton(context, wakaf),
                        SizedBox(height: 12.h),
                      ],
                    )),
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

  Widget _buildWakafButton(BuildContext context, WakafModel wakaf) {
    return GestureDetector(
      onTap: () => _navigateToWakafDetail(context, wakaf),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                wakaf.title,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.r,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}