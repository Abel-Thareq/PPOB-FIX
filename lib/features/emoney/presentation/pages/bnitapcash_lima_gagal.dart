import 'package:flutter/material.dart';
import 'package:ppob_app/features/emoney/presentation/pages/bnitapcash_satu.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class BniLimaGagalPage extends StatefulWidget {
  const BniLimaGagalPage({super.key});

  @override
  State<BniLimaGagalPage> createState() => _BniLimaGagalPageState();
}

class _BniLimaGagalPageState extends State<BniLimaGagalPage> {
  // Fungsi yang akan dipanggil saat tombol kembali ditekan
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membungkus seluruh Scaffold dengan PopScope untuk mengontrol tindakan kembali
    return PopScope(
      // canPop: false akan menonaktifkan perilaku default tombol kembali
      // sehingga kita bisa mengontrol navigasi secara manual di onPopInvoked.
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/gagal.png'),
            const SizedBox(height: 20),
            const Text(
              "Yahhh, Transaksi Gagal!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "Periksa kembali Data yang anda masukan. silahkan coba kembali dalam beberapa saat.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke BrizziSatuPage dengan menghapus riwayat navigasi
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BniTapCashSatuPage()),
                      (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5938FB),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Transaksi Baru",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onBackPressed, // Memanggil fungsi yang sama
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Kembali",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
