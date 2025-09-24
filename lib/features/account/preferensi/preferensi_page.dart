import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'preferences_provider.dart'; // Sesuaikan path jika berbeda

class PreferensiPage extends StatefulWidget {
  const PreferensiPage({super.key});

  @override
  State<PreferensiPage> createState() => _PreferensiPageState();
}

class _PreferensiPageState extends State<PreferensiPage> {
  // Variabel state LOKAL untuk mengelola UI di halaman ini saja
  late int _selectedSizeIndex;
  late String _selectedFont;

  // Daftar nilai ukuran font sesuai indeks
  final List<double> _fontSizes = [13.sp, 16.sp, 19.sp];
  
  // Daftar nama font yang tersedia
  final List<String> _fontFamilies = ["Metropolis", "Varela", "Captura"];

  // Map untuk mengubah indeks ukuran menjadi pengali (multiplier) untuk provider
  final Map<int, double> _sizeMultipliers = {
    0: 0.9, // Medium
    1: 1.0, // Besar (Default)
    2: 1.15, // Sangat Besar
  };

  @override
  void initState() {
    super.initState();
    // Ambil data awal dari provider saat halaman pertama kali dibuka
    final provider = Provider.of<PreferencesProvider>(context, listen: false);
    _selectedFont = provider.fontFamily;
    
    // Mencari indeks yang sesuai dengan multiplier yang tersimpan
    _selectedSizeIndex = _sizeMultipliers.entries
        .firstWhere((entry) => entry.value == provider.fontSizeMultiplier,
            orElse: () => const MapEntry(1, 1.0))
        .key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Header dengan box "Preferensi" (TIDAK DIUBAH)
          SizedBox(
            height: 140.h,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Image.asset(
                    'assets/images/header.png', // Pastikan path aset ini benar
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
                        'Preferensi',
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

          // 🔹 Konten utama Preferensi
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ukuran Tulisan
                  Text(
                    "Ukuran Tulisan",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSizeButton("Medium", 0),
                      _buildSizeButton("Besar", 1),
                      _buildSizeButton("Sangat Besar", 2),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Slider(
                    value: _selectedSizeIndex.toDouble(),
                    min: 0,
                    max: 2,
                    divisions: 2,
                    activeColor: const Color(0xFF5938FB),
                    onChanged: (val) {
                      setState(() {
                        _selectedSizeIndex = val.round();
                      });
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Jenis Font
                  Text(
                    "Jenis Font",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _fontFamilies
                        .map((font) => _buildFontRadio(font))
                        .toList(),
                  ),
                  SizedBox(height: 20.h),

                  // Pertinjau Teks
                  Text(
                    "Pertinjau Teks",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      "Selamat Datang di Modipay",
                      style: TextStyle(
                        fontSize: _fontSizes[_selectedSizeIndex], // Ukuran dinamis
                        fontFamily: _selectedFont, // Font dinamis
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Tombol Simpan (Dengan Logika Provider)
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Ambil instance provider (listen: false karena hanya untuk memanggil fungsi)
                        final prefProvider = Provider.of<PreferencesProvider>(context, listen: false);

                        // Ambil nilai pengali ukuran dari state lokal
                        final selectedMultiplier = _sizeMultipliers[_selectedSizeIndex]!;

                        // Panggil fungsi di provider untuk mengubah dan menyimpan preferensi
                        prefProvider.setPreferences(_selectedFont, selectedMultiplier);
                        
                        // Tampilkan notifikasi dan kembali ke halaman sebelumnya
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Preferensi berhasil disimpan!")),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5938FB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 40.w,
                        ),
                      ),
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk tombol ukuran font
  Widget _buildSizeButton(String label, int index) {
    final bool isSelected = _selectedSizeIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSizeIndex = index;
        });
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF5938FB) : Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: isSelected ? null : Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              "Aa",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Text(label),
        ],
      ),
    );
  }

  // Widget helper untuk Radio Button font
  Widget _buildFontRadio(String fontName) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: fontName,
          groupValue: _selectedFont,
          activeColor: const Color(0xFF5938FB),
          onChanged: (value) {
            setState(() {
              _selectedFont = value!;
            });
          },
        ),
        Text(fontName),
      ],
    );
  }
}