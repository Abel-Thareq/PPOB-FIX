import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/account/preferensi/preferences_provider.dart';
import 'package:provider/provider.dart';

class PengaturanStrukPage extends StatefulWidget {
  const PengaturanStrukPage({super.key});

  @override
  State<PengaturanStrukPage> createState() => _PengaturanStrukPageState();
}

class _PengaturanStrukPageState extends State<PengaturanStrukPage> {
  // Toggle struk
  late bool _showLogo;
  late bool _showPhone;
  late bool _showAddress;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PreferencesProvider>(context, listen: false);
    _showLogo = provider.showLogo;
    _showPhone = provider.showPhone;
    _showAddress = provider.showAddress;
  }

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
                      icon: Icon(Icons.arrow_back,
                          size: 28.r, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 24.w,
                  right: 24.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        'Pengaturan Struk',
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

          // 🔹 Konten
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pilih Tampilan Struk",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 12.h),

                  // Toggle opsi struk
                  SwitchListTile(
                    title: const Text("Tampilkan Logo Pada Struk"),
                    value: _showLogo,
                    activeColor: const Color(0xFF5938FB),
                    onChanged: (val) => setState(() => _showLogo = val),
                  ),
                  SwitchListTile(
                    title: const Text("Tampilkan Alamat pada Struk"),
                    value: _showAddress,
                    activeColor: const Color(0xFF5938FB),
                    onChanged: (val) => setState(() => _showAddress = val),
                  ),
                  SwitchListTile(
                    title: const Text("Tampilkan Nomor Telfon pada Struk"),
                    value: _showPhone,
                    activeColor: const Color(0xFF5938FB),
                    onChanged: (val) => setState(() => _showPhone = val),
                  ),

                  SizedBox(height: 24.h),

                  // 🔹 Tombol Simpan
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        final prefProvider = Provider.of<PreferencesProvider>(
                            context,
                            listen: false);

                        prefProvider.setStrukPreferences(
                          showLogo: _showLogo,
                          showPhone: _showPhone,
                          showAddress: _showAddress,
                        );

                        // 🔹 Pop up snackbar custom
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Berhasil mengubah preferensi tampilan struk",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            margin: EdgeInsets.all(16.r),
                            duration: const Duration(seconds: 2),
                          ),
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5938FB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 40.w),
                      ),
                      child: Text("Simpan",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}