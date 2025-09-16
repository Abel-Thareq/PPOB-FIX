import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/home/presentation/pages/tagihan_page.dart';

class ReksaDuaPage extends StatefulWidget {
  const ReksaDuaPage({super.key});

  @override
  State<ReksaDuaPage> createState() => _ReksaDuaPageState();
}

class _ReksaDuaPageState extends State<ReksaDuaPage> {
  String selectedIncomeSource = "Gaji";
  String selectedIncomeRange = "Rp50–99 Juta";
  String selectedRiskProfile = "Agresif";

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
            // HEADER
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6A1B9A), Color(0xFF7E57C2)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 28,
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
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'modipay',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'SATU PINTU SEMUA PEMBAYARAN',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // KONTEN
            Expanded(
              child: SingleChildScrollView(
                // Hapus padding horizontal agar konten bisa full width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tombol Formulir Data (seperti tab)
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 16.h),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          "Formulir Data",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Email - tambahkan padding horizontal hanya untuk bagian ini
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Alamat Email"),
                          SizedBox(height: 8.h),
                          _buildInfoBox("abel.thareq88@gmail.com"),
                          SizedBox(height: 12.h),
                          
                          // Box Alert Ungu dengan icon peringatan
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: Color(0xFFF3E5F5), // Warna ungu muda
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Color(0xFF7B1FA2), width: 1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  size: 18.r,
                                  color: Color(0xFF7B1FA2),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    "Pastikan email yang tertera benar karena akan didaftarkan sebagai akun investor KSEI.",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Color(0xFF7B1FA2),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Informasi Pribadi - dalam kotak abu-abu (FULL WIDTH)
                    _buildSectionBoxFullWidth("INFORMASI PRIBADI"),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          // Sumber Penghasilan - bisa diklik
                          GestureDetector(
                            onTap: () => _showIncomeSourceBottomSheet(context),
                            child: _buildListTile("Sumber Penghasilan", selectedIncomeSource),
                          ),
                          SizedBox(height: 12.h),
                          // Penghasilan per Tahun - bisa diklik
                          GestureDetector(
                            onTap: () => _showIncomeRangeBottomSheet(context),
                            child: _buildListTile("Penghasilan per Tahun", selectedIncomeRange),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Profil Resiko - dalam kotak abu-abu (FULL WIDTH)
                    _buildSectionBoxFullWidth("PROFIL RESIKO"),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profil Resiko - bisa diklik
                          GestureDetector(
                            onTap: () => _showRiskProfileBottomSheet(context),
                            child: _buildListTile("Profil Resiko", selectedRiskProfile),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Cukup siap jika jumlah modal investasi awal berkurang drastis asal punya peluang dapat untung tinggi.",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Data Pribadi - dalam kotak abu-abu (FULL WIDTH)
                    _buildSectionBoxFullWidth("DATA PRIBADI"),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          _buildPersonalDataItem("Nama Lengkap", "EBEL THAREQ COBRA"),
                          SizedBox(height: 12.h),
                          _buildPersonalDataItem("Jenis Kelamin", "Laki-laki"),
                          SizedBox(height: 12.h),
                          _buildPersonalDataItem("Nomor KTP", "3308 1021 1104 0003"),
                          SizedBox(height: 12.h),
                          _buildPersonalDataItem("Tempat Lahir", "MAGELANG"),
                          SizedBox(height: 12.h),
                          _buildPersonalDataItem("Tanggal Lahir", "21 November 2004"),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Checkbox
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.deepPurple,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              "Saya mengerti dan menyetujui Syarat & Ketentuan serta Kebijakan Privasi berlaku.",
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Tombol Kirim
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6A1B9A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () {
                            // TODO: aksi kirim formulir
                          },
                          child: Text(
                            "Kirim",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
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

  // Method untuk menampilkan bottom sheet Sumber Penghasilan
  void _showIncomeSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Sumber Penghasilan",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildOptionItem("Gaji", selectedIncomeSource == "Gaji", () {
                setState(() {
                  selectedIncomeSource = "Gaji";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Warisan", selectedIncomeSource == "Warisan", () {
                setState(() {
                  selectedIncomeSource = "Warisan";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Hasil Usaha", selectedIncomeSource == "Hasil Usaha", () {
                setState(() {
                  selectedIncomeSource = "Hasil Usaha";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Lainnya", selectedIncomeSource == "Lainnya", () {
                setState(() {
                  selectedIncomeSource = "Lainnya";
                });
                Navigator.pop(context);
              }),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  // Method untuk menampilkan bottom sheet Penghasilan per Tahun
  void _showIncomeRangeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Penghasilan per Tahun",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildOptionItem("Rp10 Juta", selectedIncomeRange == "Rp10 Juta", () {
                setState(() {
                  selectedIncomeRange = "Rp10 Juta";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Rp10–49 Juta", selectedIncomeRange == "Rp10–49 Juta", () {
                setState(() {
                  selectedIncomeRange = "Rp10–49 Juta";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Rp50–99 Juta", selectedIncomeRange == "Rp50–99 Juta", () {
                setState(() {
                  selectedIncomeRange = "Rp50–99 Juta";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Rp100–499 Juta", selectedIncomeRange == "Rp100–499 Juta", () {
                setState(() {
                  selectedIncomeRange = "Rp100–499 Juta";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Rp500–999 Juta", selectedIncomeRange == "Rp500–999 Juta", () {
                setState(() {
                  selectedIncomeRange = "Rp500–999 Juta";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("> Rp1M", selectedIncomeRange == "> Rp1M", () {
                setState(() {
                  selectedIncomeRange = "> Rp1M";
                });
                Navigator.pop(context);
              }),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  // Method untuk menampilkan bottom sheet Profil Resiko
  void _showRiskProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Profil Resiko",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildOptionItem("Konservatif", selectedRiskProfile == "Konservatif", () {
                setState(() {
                  selectedRiskProfile = "Konservatif";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Moderat", selectedRiskProfile == "Moderat", () {
                setState(() {
                  selectedRiskProfile = "Moderat";
                });
                Navigator.pop(context);
              }),
              _buildOptionItem("Agresif", selectedRiskProfile == "Agresif", () {
                setState(() {
                  selectedRiskProfile = "Agresif";
                });
                Navigator.pop(context);
              }),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  // Widget untuk membuat item opsi dalam bottom sheet
  Widget _buildOptionItem(String title, bool isSelected, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          color: isSelected ? Colors.deepPurple : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: Colors.deepPurple,
              size: 20.r,
            )
          : null,
      onTap: onTap,
    );
  }

  // Widget untuk membuat section title dalam kotak abu-abu FULL WIDTH
  Widget _buildSectionBoxFullWidth(String title) {
    return Container(
      width: double.infinity, // Memastikan lebar penuh
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), // Kurangi vertical padding
      decoration: BoxDecoration(
        color: Colors.grey[300], // Warna abu yang lebih gelap
        borderRadius: BorderRadius.zero, // Hapus border radius untuk full width
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11.sp, // Perkecil font size
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildInfoBox(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h), // Kurangi vertical padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp, // Perkecil font size
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp, // Perkecil font size
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.deepPurple,
                size: 20.r,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalDataItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp, // Perkecil font size
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h), // Kurangi vertical padding
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13.sp, // Perkecil font size
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}