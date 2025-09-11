import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:ppob_app/features/main_screen/main_screen.dart';

class PascabayarLimaBerhasil extends StatefulWidget {
  final int nominalTagihan;
  final int biayaAdmin;
  final String namaPelanggan;
  final String nomorHp;

  const PascabayarLimaBerhasil({
    super.key,
    required this.nominalTagihan,
    required this.biayaAdmin,
    required this.namaPelanggan,
    required this.nomorHp,
  });

  @override
  State<PascabayarLimaBerhasil> createState() => _PascabayarLimaBerhasilState();
}

class _PascabayarLimaBerhasilState extends State<PascabayarLimaBerhasil> {
  // Format mata uang
  String formatCurrency(int amount) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(amount);
  }

  // Generate string acak
  String _generateRandomString(int length) {
    final random = Random();
    const chars = "0123456789";
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  void _onBackPressed() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
  }

  // Bagikan detail transaksi
  void _shareTransactionDetails() {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';
    final noRef = _generateRandomString(20);
    final totalPembelian = widget.nominalTagihan + widget.biayaAdmin;

    final details = """
    Transaksi Berhasil!

    Detail Pembayaran Telkom:
    ----------------------------------------
    Tanggal: $formattedDate
    No. Ref: $noRef
    Sumber Dana: ${widget.namaPelanggan}
    Jenis Transaksi: Bayar Telkom
    Nama Pelanggan: ${widget.namaPelanggan}
    Nomor Pelanggan: ${widget.nomorHp}
    Harga: ${formatCurrency(widget.nominalTagihan)}
    Denda: ${formatCurrency(0)}
    Biaya Admin: ${formatCurrency(widget.biayaAdmin)}
    Total Pembelian: ${formatCurrency(totalPembelian)}
    ----------------------------------------
      """;

    Clipboard.setData(ClipboardData(text: details)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Detail Transaksi berhasil di copy"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPembelian = widget.nominalTagihan + widget.biayaAdmin;
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
            // Konten utama
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 140, bottom: 20, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  const SizedBox(height: 13),
                  const Text(
                    "Transaksi Berhasil",
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
                        _DetailRow("Sumber Dana", widget.namaPelanggan),
                        _DetailRow("Jenis Transaksi", "Bayar Telkom"),
                        _DetailRow("Nama Pelanggan", widget.namaPelanggan),
                        _DetailRow("Nomor Pelanggan", widget.nomorHp),
                        const SizedBox(height: 16),
                        Divider(height: 1, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        _DetailRow("Harga", formatCurrency(widget.nominalTagihan)),
                        _DetailRow("Denda", formatCurrency(0)), 
                        _DetailRow("Biaya Admin", formatCurrency(widget.biayaAdmin)),
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
                          onPressed: _shareTransactionDetails,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6C4EFF),
                            side: const BorderSide(color: Color(0xFF6C4EFF)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Bagikan',
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
                          onPressed: _onBackPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C4EFF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Selesai',
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
            // Tombol back
            Positioned(
              top: 43,
              left: 19,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 28,
                  padding: const EdgeInsets.all(12),
                  onPressed: _onBackPressed,
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
