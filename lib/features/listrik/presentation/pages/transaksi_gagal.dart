import 'package:flutter/material.dart';
import 'package:ppob_app/features/listrik/presentation/pages/ProdukListrik_page.dart';
import 'package:ppob_app/features/listrik/presentation/pages/listrik_page.dart'; // Import EMoneyPage

// Ubah menjadi StatefulWidget untuk mengelola state dan mengontrol navigasi.
class TransaksiGagalPage extends StatefulWidget {
  const TransaksiGagalPage({super.key});

  @override
  State<TransaksiGagalPage> createState() => _TransaksiGagalPageState();
}

class _TransaksiGagalPageState extends State<TransaksiGagalPage> {
  // Fungsi yang akan dipanggil saat tombol "Kembali" atau tombol kembali perangkat ditekan.
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ListrikPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membungkus seluruh Scaffold dengan PopScope untuk mengontrol navigasi.
    return PopScope(
      // canPop: false menonaktifkan perilaku default tombol kembali.
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
                  MaterialPageRoute(builder: (context) => const ListrikProdukPage()),
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
              onPressed: _onBackPressed, // Menggunakan fungsi _onBackPressed
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
