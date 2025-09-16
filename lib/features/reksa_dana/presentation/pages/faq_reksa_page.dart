import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/home/presentation/pages/tagihan_page.dart';

class FaqReksaPage extends StatelessWidget {
  const FaqReksaPage({super.key});

  // ---------- MODAL SHEETS ---------- //
  void _showReksaDanaInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildBottomSheet(
          context,
          title: 'Apa itu Reksa Dana?',
          content:
              'Reksa Dana adalah wadah yang menghimpun dana dari masyarakat pemodal untuk selanjutnya diinvestasikan dalam portofolio efek oleh Manajer Investasi. Dana yang terkumpul kemudian dikelola oleh Manajer Investasi ke dalam berbagai instrumen investasi seperti saham, obligasi, pasar uang, atau kombinasi thereof.',
          items: [
            'Dikelola oleh profesional di bidangnya',
            'Diversifikasi investasi untuk mengurangi risiko',
            'Modal awal terjangkau',
            'Likuiditas yang baik',
          ],
        );
      },
    );
  }

  void _showProdukInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildBottomSheetProduk(context);
      },
    );
  }

  void _showKeamananInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildBottomSheet(
          context,
          title: 'Keamanan Investasi Reksa Dana',
          content:
              'Aman karena diawasi OJK (Otoritas Jasa Keuangan). Namun, nilai investasi bisa naik turun sesuai kondisi pasar.',
          items: [
            'Diawasi langsung oleh OJK',
            'Transaksi tercatat dan teraudit',
            'Dana investor dipisahkan dari aset perusahaan',
            'Laporan keuangan tersedia untuk publik',
          ],
        );
      },
    );
  }

  void _showInvestasiInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildBottomSheet(
          context,
          title: 'Apa itu Investasi dan Risikonya?',
          content:
              'Investasi adalah kegiatan menanamkan dana atau aset dengan harapan mendapatkan keuntungan di masa depan. Namun, investasi juga memiliki risiko seperti nilai yang bisa turun karena kondisi pasar, sulitnya pencairan dana, kemungkinan gagal bayar, atau tergerus inflasi.',
          items: [
            'Semakin tinggi potensi keuntungan, semakin tinggi pula risikonya',
            'Diversifikasi untuk mengurangi risiko',
            'Investasi jangka panjang biasanya memberikan hasil lebih baik',
            'Pahami produk sebelum berinvestasi',
          ],
        );
      },
    );
  }

  void _showPembelianInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildBottomSheetTimeline(
          context,
          title: 'Proses Pembelian Reksa Dana',
          desc: 'Proses pembelian reksa dana membutuhkan 1 hingga 2 hari kerja.',
          items: [
            ['Sebelum cut-off (13.00 WIB)', 'Unit masuk esok hari'],
            ['Setelah cut-off (13.00 WIB)', 'Unit masuk lusa'],
          ],
        );
      },
    );
  }

  void _showPenjualanInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _buildBottomSheetTimeline(
          context,
          title: 'Proses Penjualan Reksa Dana',
          desc:
              'Proses penjualan reksa dana membutuhkan waktu 1 hingga 7 hari kerja sejak pengajuan perintah penjualan. Waktu pastinya tergantung pada jenis reksa dana dan kebijakan Bank Kustodian.',
          items: [
            ['Reksa Dana Pasar Uang', '1-2 hari kerja'],
            ['Reksa Dana Pendapatan Tetap', '2-3 hari kerja'],
            ['Reksa Dana Campuran', '3-5 hari kerja'],
            ['Reksa Dana Saham', '4-7 hari kerja'],
          ],
        );
      },
    );
  }

  // ---------- REUSABLE WIDGETS ---------- //
  Widget _buildBottomSheet(BuildContext context,
      {required String title, required String content, List<String>? items}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(title,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          SizedBox(height: 16.h),
          Text(content,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
          if (items != null) ...[
            SizedBox(height: 16.h),
            ...items.map((e) => _buildInfoItem(e)),
          ],
          SizedBox(height: 24.h),
          _buildCloseBtn(context),
        ],
      ),
    );
  }

  Widget _buildBottomSheetProduk(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text("Produk Reksa Dana yang Tersedia",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          SizedBox(height: 16.h),
          _buildProdukItem("Reksa Dana Pasar Uang", "Risiko rendah, jangka pendek"),
          _buildProdukItem("Reksa Dana Pendapatan Tetap", "Risiko menengah"),
          _buildProdukItem("Reksa Dana Campuran", "Risiko menengah–tinggi"),
          _buildProdukItem("Reksa Dana Saham", "Risiko tinggi, potensi imbal hasil besar"),
          _buildProdukItem("Reksa Dana Indeks/ETF", "Mengikuti indeks pasar"),
          SizedBox(height: 24.h),
          _buildCloseBtn(context),
        ],
      ),
    );
  }

  Widget _buildBottomSheetTimeline(BuildContext context,
      {required String title,
      required String desc,
      required List<List<String>> items}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(title,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          SizedBox(height: 16.h),
          Text(desc,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
          SizedBox(height: 16.h),
          ...items.map((e) => _buildTimelineItem(e[0], e[1])),
          SizedBox(height: 24.h),
          _buildCloseBtn(context),
        ],
      ),
    );
  }

  Widget _buildCloseBtn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: const Text("Tutup"),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 16, color: Colors.green),
          SizedBox(width: 8.w),
          Expanded(
              child: Text(text,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]))),
        ],
      ),
    );
  }

  Widget _buildProdukItem(String produk, String deskripsi) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(produk,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          SizedBox(height: 4.h),
          Text(deskripsi,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String waktu, String keterangan) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          const Icon(Icons.access_time, size: 16, color: Colors.blue),
          SizedBox(width: 8.w),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(waktu,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87)),
              Text(keterangan,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700])),
            ],
          )),
        ],
      ),
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
          MaterialPageRoute(builder: (_) => const TagihanPage()),
          (route) => false,
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            // HEADER dengan balok putih berisi "FAQ"
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
                            MaterialPageRoute(builder: (_) => const TagihanPage()),
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
                          'FAQ',
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

            // KONTEN FAQ
            Expanded(
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item FAQ
                    _buildFaqButton(
                        context, "Apa itu Reksa Dana?", _showReksaDanaInfo),
                    SizedBox(height: 12.h),
                    _buildFaqButton(context,
                        "Apa saja produk Reksa Dana yang tersedia di aplikasi modipay?",
                        _showProdukInfo),
                    SizedBox(height: 12.h),
                    _buildFaqButton(context,
                        "Apakah aman berinvestasi Reksa Dana melalui aplikasi modipay?",
                        _showKeamananInfo),
                    SizedBox(height: 12.h),
                    _buildFaqButton(context,
                        "Apakah itu investasi dan bagaimana resikonya?",
                        _showInvestasiInfo),
                    SizedBox(height: 12.h),
                    _buildFaqButton(context,
                        "Berapa lama proses pembelian Reksa Dana?",
                        _showPembelianInfo),
                    SizedBox(height: 12.h),
                    _buildFaqButton(context,
                        "Berapa lama proses penjualan Reksa Dana?",
                        _showPenjualanInfo),
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

  Widget _buildFaqButton(
      BuildContext context, String text, Function(BuildContext) onTap) {
    return GestureDetector(
      onTap: () => onTap(context),
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
                child: Text(text,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87))),
            Icon(Icons.arrow_forward_ios,
                size: 16.r, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }
}