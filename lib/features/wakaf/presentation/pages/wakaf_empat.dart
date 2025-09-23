import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/wakaf/presentation/pages/wakaf_tiga.dart';
import 'wakaf_model.dart';

class WakafEmpatPage extends StatefulWidget {
  final WakafModel wakaf;
  
  const WakafEmpatPage({super.key, required this.wakaf});

  @override
  State<WakafEmpatPage> createState() => _WakafEmpatPageState();
}

class _WakafEmpatPageState extends State<WakafEmpatPage> {
  int? _selectedAmount;
  
  // Daftar nominal donasi
  final List<Map<String, dynamic>> _donationAmounts = [
    {'label': 'Donasi 3K', 'amount': 3000},
    {'label': 'Donasi 5K', 'amount': 5000},
    {'label': 'Donasi 10K', 'amount': 10000},
    {'label': 'Donasi 15K', 'amount': 15000},
    {'label': 'Donasi 20K', 'amount': 20000},
    {'label': 'Donasi 30K', 'amount': 30000},
    {'label': 'Donasi 50K', 'amount': 50000},
    {'label': 'Donasi 75K', 'amount': 75000},
    {'label': 'Donasi 100K', 'amount': 100000},
    {'label': 'Donasi 250K', 'amount': 250000},
    {'label': 'Donasi 500K', 'amount': 500000},
    {'label': 'Donasi 1000K', 'amount': 1000000},
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
          MaterialPageRoute(builder: (_) => WakafTigaPage(wakaf: widget.wakaf)),
          (route) => false,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // HEADER
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
                            MaterialPageRoute(builder: (_) => WakafTigaPage(wakaf: widget.wakaf)),
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
                          widget.wakaf.title,
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

            // KONTEN UTAMA
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Grid Pilihan Donasi - DIUBAH MENJADI 2 KOLOM
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // DIUBAH DARI 3 MENJADI 2
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 2.5, // DIUBAH DARI 1.8 MENJADI 2.5 UNTUK BOX LEBIH BESAR
                      ),
                      itemCount: _donationAmounts.length,
                      itemBuilder: (context, index) {
                        final donation = _donationAmounts[index];
                        final isSelected = _selectedAmount == donation['amount'];
                        
                        return _buildDonationOption(
                          donation['label'],
                          donation['amount'],
                          isSelected,
                          index,
                        );
                      },
                    ),
                    SizedBox(height: 40.h), // DIUBAH DARI 24.h MENJADI 40.h UNTUK TOMBOL LEBIH KEBAWAH

                    // Tombol "Lanjutkan" - DITAMBAH SPACING LEBIH BANYAK
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedAmount != null
                            ? () {
                                _processDonation(context, _selectedAmount!);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedAmount != null 
                              ? const Color(0xFF5938FB)
                              : Colors.grey[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          elevation: 2,
                        ),
                        child: Text(
                          'Lanjutkan',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h), // DIUBAH DARI 24.h MENJADI 40.h
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationOption(String label, int amount, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAmount = isSelected ? null : amount;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5938FB) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF5938FB) : Colors.grey[300]!,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp, // DIUBAH DARI 12.sp MENJADI 14.sp UNTUK TEKS LEBIH BESAR
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: 6.h), // DIUBAH DARI 4.h MENJADI 6.h
            Text(
              _formatCurrency(amount),
              style: TextStyle(
                fontSize: 13.sp, // DIUBAH DARI 11.sp MENJADI 13.sp UNTUK TEKS LEBIH BESAR
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    if (amount >= 1000000) {
      return 'Rp${(amount / 1000000).toStringAsFixed(0)}.000.000';
    } else if (amount >= 1000) {
      return 'Rp${(amount / 1000).toStringAsFixed(0)}.000';
    }
    return 'Rp$amount';
  }

  void _processDonation(BuildContext context, int amount) {
    // Tampilkan dialog konfirmasi
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Donasi',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Program: ${widget.wakaf.title}',
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Nominal: ${_formatCurrency(amount)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5938FB),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Apakah Anda yakin ingin melanjutkan donasi?',
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal', style: TextStyle(fontSize: 14.sp)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessDialog(context, amount);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5938FB),
                foregroundColor: Colors.white,
              ),
              child: Text('Ya, Lanjutkan', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, int amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 48.r,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Donasi Berhasil!',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Terima kasih telah berdonasi sebesar ${_formatCurrency(amount)} untuk program ${widget.wakaf.title}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => WakafTigaPage(wakaf: widget.wakaf)),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5938FB),
                foregroundColor: Colors.white,
              ),
              child: Text('Kembali', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        );
      },
    );
  }
}