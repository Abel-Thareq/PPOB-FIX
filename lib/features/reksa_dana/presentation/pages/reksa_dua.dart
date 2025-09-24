import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/home/presentation/pages/lainnyahome_page.dart';

import 'package:ppob_app/features/reksa_dana/presentation/pages/reksa_tiga.dart';

class ReksaDuaPage extends StatefulWidget {
  const ReksaDuaPage({super.key});

  @override
  State<ReksaDuaPage> createState() => _ReksaDuaPageState();
}

class _ReksaDuaPageState extends State<ReksaDuaPage> {
  String selectedIncomeSource = "Gaji";
  String selectedIncomeRange = "Rp50–99 Juta";
  String selectedRiskProfile = "Moderat";
  
  // Variabel untuk kuesioner profil risiko
  String selectedInvestmentPeriod = "1–5 Tahun";
  String selectedInvestmentGoal = "Pertumbuhan Laba (Jangka Panjang)";
  String selectedFundAllocation = "25–50%";
  String selectedMaxAssetDecline = "25–50%";
  String selectedFundKnowledge = "Tinggi";
  String selectedProductKnowledge = "Tinggi";

  // Variabel untuk checkbox
  bool isAgreeToTerms = false;

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
            // HEADER - PAKAI IMAGE ASSET (sesuai permintaan)
            SizedBox(
              height: 140.h,
              child: Stack(
                children: [
                  // Ganti gradient dengan gambar header.png
                  SizedBox(
                    width: double.infinity,
                    height: 120.h,
                    child: Image.asset(
                      "assets/images/header.png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Tombol back di atas gambar
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, size: 28.r),
                        color: Colors.white,
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

                  // BOX "Formulir Data" melayang di bawah header (sama seperti desain)
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
                          'Formulir Data',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // KONTEN
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 24.h,
                  bottom: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email
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
                              color: Color(0xFFF3E5F5),
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

                    // Informasi Pribadi - DIPERBAIKI: Section box full width
                    _buildSectionBoxFullWidth("INFORMASI PRIBADI"),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _showIncomeSourceBottomSheet(context),
                            child: _buildListTile("Sumber Penghasilan", selectedIncomeSource),
                          ),
                          SizedBox(height: 12.h),
                          GestureDetector(
                            onTap: () => _showIncomeRangeBottomSheet(context),
                            child: _buildListTile("Penghasilan per Tahun", selectedIncomeRange),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Profil Resiko - DIPERBAIKI: Section box full width
                    _buildSectionBoxFullWidth("PROFIL RESIKO"),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => _showRiskProfileQuestionnaire(context),
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

                    // Data Pribadi - DIPERBAIKI: Section box full width
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

                    // Checkbox - DIPERBAIKI
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isAgreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                isAgreeToTerms = value ?? false;
                              });
                            },
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

                    // Tombol Kirim - DIPERBAIKI (dinonaktifkan jika belum setuju)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAgreeToTerms 
                                ? const Color(0xFF6A1B9A) 
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: isAgreeToTerms
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const ReksaTigaPage()),
                              );
                            }
                          : null,
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

  // Widget untuk membuat section title dalam kotak abu-abu FULL WIDTH - DIPERBAIKI
  Widget _buildSectionBoxFullWidth(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.zero,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Method untuk menampilkan kuesioner profil risiko
  void _showRiskProfileQuestionnaire(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.all(16.w),
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
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
                  Center(
                    child: Text(
                      "Profil Risiko Saya",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // Hasil Profil Risiko
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          selectedRiskProfile,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          _getRiskProfileDescription(selectedRiskProfile),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.deepPurple[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Periode Investasi
                          _buildQuestionnaireItem(
                            "Periode investasi yang diinginkan",
                            selectedInvestmentPeriod,
                            ["< 1 Tahun", "1–5 Tahun", "> 5 Tahun"],
                            (value) {
                              setModalState(() {
                                selectedInvestmentPeriod = value;
                              });
                              _calculateRiskProfile();
                            },
                          ),
                          
                          // Tujuan Investasi
                          _buildQuestionnaireItem(
                            "Tujuan Investasi Reksa Dana",
                            selectedInvestmentGoal,
                            [
                              "Pendapatan Tetap (Jangka Pendek)",
                              "Pertumbuhan Laba (Jangka Panjang)",
                              "Spekulasi (High Risk High Return)"
                            ],
                            (value) {
                              setModalState(() {
                                selectedInvestmentGoal = value;
                              });
                              _calculateRiskProfile();
                            },
                          ),
                          
                          // Alokasi Reksa Dana
                          _buildQuestionnaireItem(
                            "Alokasi Reksa Dana dari Total Aset",
                            selectedFundAllocation,
                            ["< 25%", "25–50%", "> 50%"],
                            (value) {
                              setModalState(() {
                                selectedFundAllocation = value;
                              });
                              _calculateRiskProfile();
                            },
                          ),
                          
                          // Maksimum Penurunan Aset
                          _buildQuestionnaireItem(
                            "Maksimum Penurunan Aset",
                            selectedMaxAssetDecline,
                            ["< 25%", "25–50%", "> 50%"],
                            (value) {
                              setModalState(() {
                                selectedMaxAssetDecline = value;
                              });
                              _calculateRiskProfile();
                            },
                          ),
                          
                          // Pengetahuan Reksa Dana
                          _buildQuestionnaireItem(
                            "Pengetahuan Reksa Dana",
                            selectedFundKnowledge,
                            ["Rendah", "Sedang", "Tinggi"],
                            (value) {
                              setModalState(() {
                                selectedFundKnowledge = value;
                              });
                              _calculateRiskProfile();
                            },
                          ),
                          
                          // Pengetahuan Produk
                          _buildQuestionnaireItem(
                            "Pengetahuan Produk Ingin Dibeli",
                            selectedProductKnowledge,
                            ["Rendah", "Sedang", "Tinggi"],
                            (value) {
                              setModalState(() {
                                selectedProductKnowledge = value;
                              });
                              _calculateRiskProfile();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _calculateRiskProfile();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Simpan Profil Risiko",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Method untuk mendapatkan deskripsi profil risiko
  String _getRiskProfileDescription(String profile) {
    switch (profile) {
      case "Konservatif":
        return "Lebih memilih investasi aman dengan risiko rendah dan return yang stabil.";
      case "Moderat":
        return "Seimbang antara risiko dan return, mau mengambil risiko sedang untuk return yang lebih baik.";
      case "Agresif":
        return "Cukup siap jika jumlah modal investasi awal berkurang drastis asal punya peluang dapat untung tinggi.";
      default:
        return "";
    }
  }

  // Method untuk menghitung profil risiko berdasarkan jawaban
  void _calculateRiskProfile() {
    int score = 0;
    
    // Scoring berdasarkan jawaban
    if (selectedInvestmentPeriod == "1–5 Tahun") score += 1;
    if (selectedInvestmentPeriod == "> 5 Tahun") score += 2;
    
    if (selectedInvestmentGoal == "Pertumbuhan Laba (Jangka Panjang)") score += 1;
    if (selectedInvestmentGoal == "Spekulasi (High Risk High Return)") score += 2;
    
    if (selectedFundAllocation == "25–50%") score += 1;
    if (selectedFundAllocation == "> 50%") score += 2;
    
    if (selectedMaxAssetDecline == "25–50%") score += 1;
    if (selectedMaxAssetDecline == "> 50%") score += 2;
    
    if (selectedFundKnowledge == "Sedang") score += 1;
    if (selectedFundKnowledge == "Tinggi") score += 2;
    
    if (selectedProductKnowledge == "Sedang") score += 1;
    if (selectedProductKnowledge == "Tinggi") score += 2;
    
    // Tentukan profil risiko berdasarkan score
    if (score <= 6) {
      selectedRiskProfile = "Konservatif";
    } else if (score <= 11) {
      selectedRiskProfile = "Moderat";
    } else {
      selectedRiskProfile = "Agresif";
    }
  }

  // Widget untuk item kuesioner
  Widget _buildQuestionnaireItem(String question, String selectedValue, List<String> options, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          question,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: options.map((option) {
            final isSelected = option == selectedValue;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onChanged(option);
                }
              },
              selectedColor: Colors.deepPurple,
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12.sp,
              ),
            );
          }).toList(),
        ),
      ],
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
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
            fontSize: 11.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}