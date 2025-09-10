import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:ppob_app/features/main_screen/main_screen.dart';
// Import halaman EinvoicingPage
import 'package:ppob_app/features/einvoicing/presentation/pages/einvoicing_page.dart';

class EinvoicingEmpatGagal extends StatefulWidget {
  final String publisher;
  final String paymentCode;

  const EinvoicingEmpatGagal({
    super.key,
    required this.publisher,
    required this.paymentCode,
  });

  @override
  State<EinvoicingEmpatGagal> createState() => _EinvoicingEmpatGagalState();
}

class _EinvoicingEmpatGagalState extends State<EinvoicingEmpatGagal> {
  // Data dummy
  final int nominalTagihan = 1500000;
  final int biayaAdmin = 0;
  final String namaPelanggan = "ABEL THAREG";
  final String namaWP = "ALFIN CHIPMUNK";

  // Fungsi untuk memformat mata uang
  String formatCurrency(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  // Fungsi untuk menghasilkan string acak
  String _generateRandomString(int length) {
    final random = Random();
    const chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // Fungsi saat tombol kembali ditekan
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Fungsi saat tombol coba lagi ditekan - NAVIGASI KE EINVOICINGPAGE
  void _onTryAgainPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => EinvoicingPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPembelian = nominalTagihan + biayaAdmin;
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            // Header dengan gambar latar belakang
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/header.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Konten utama
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 140, bottom: 20, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 13),
                  const Text(
                    "Transaksi Gagal",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DetailRow("Tanggal", formattedDate),
                        _DetailRow("No. Ref", noRef),
                        const SizedBox(height: 16),
                        Divider(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        _DetailRow("Sumber Dana", namaPelanggan),
                        _DetailRow("Jenis Transaksi", "E-Invoicing"),
                        _DetailRow("Kode Pembayaran", widget.paymentCode),
                        _DetailRow("Nama WP", namaWP),
                        const SizedBox(height: 16),
                        Divider(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        _DetailRow("Harga", formatCurrency(nominalTagihan)),
                        _DetailRow("Denda", formatCurrency(0)),
                        _DetailRow("Biaya Admin", formatCurrency(biayaAdmin)),
                        const SizedBox(height: 16),
                        Divider(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Pembelian",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              formatCurrency(totalPembelian),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6C4EFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _onBackPressed,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Kembali',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _onTryAgainPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Coba Lagi',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tombol back
            Positioned(
              top: 10,
              left: 20,
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 24,
                    onPressed: _onBackPressed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}