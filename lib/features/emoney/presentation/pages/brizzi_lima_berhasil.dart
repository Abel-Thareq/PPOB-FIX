import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

// Ubah menjadi StatefulWidget untuk mengelola state dan mengontrol navigasi.
class BrizziLimaBerhasilPage extends StatefulWidget {
  final int totalPesanan;
  final int biayaAdmin;

  const BrizziLimaBerhasilPage({
    super.key,
    required this.totalPesanan,
    required this.biayaAdmin,
  });

  @override
  State<BrizziLimaBerhasilPage> createState() => _BrizziLimaBerhasilPageState();
}

class _BrizziLimaBerhasilPageState extends State<BrizziLimaBerhasilPage> {
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Fungsi yang akan dipanggil saat tombol "Kembali" atau tombol kembali perangkat ditekan.
  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalTransaksi = widget.totalPesanan + widget.biayaAdmin;

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
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            // Main Scrollable Content
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 160),
              child: Column(
                children: [
                  // Main Content Box
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
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
                        // Header Transaksi
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(
                            'assets/images/header.png',
                            height: 80,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "13 Agus 2025   15:27",
                                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.check_circle, color: Colors.green, size: 18),
                                      SizedBox(width: 6),
                                      Text("Transaksi Berhasil",
                                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "877924005731",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.copy, size: 18),
                                      onPressed: () {},
                                      padding: EdgeInsets.zero,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text("No. Pesanan",
                                  style: TextStyle(fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                        const Divider(height: 1, thickness: 0.5),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon BRIZZI (gunakan placeholder atau ganti dengan aset yang sesuai)
                              Image.asset('assets/images/iconbri.png', width: 36, height: 36),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("BRIZZI",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 2),
                                    Text("Nomor Kartu",
                                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    Text("7546 0000 0604 6433",
                                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1, thickness: 0.5),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Informasi Pembayaran",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C4EFF),
                                ),
                              ),
                              const SizedBox(height: 10),
                              _DetailRow("Metode Pembayaran", "Saldo Modipay"),
                              _DetailRow("Jumlah Pesanan", formatCurrency(widget.totalPesanan)),
                              _DetailRow("Biaya Admin", formatCurrency(widget.biayaAdmin)),
                              const Divider(height: 12),
                              _DetailRow("Total Transaksi", formatCurrency(totalTransaksi), isBold: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Share Button
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C4EFF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Bagikan",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text("Diamankan oleh Modipay", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ),
                ],
              ),
            ),
            // Header Background
            SizedBox(
              height: 140,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            // Back Button di atas scrollable
            Positioned(
              top: 16,
              left: 16,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 28,
                  onPressed: _onBackPressed, // Menggunakan fungsi _onBackPressed
                ),
              ),
            ),
            // "Detail Transaksi" Box overlapping
            Positioned(
              top: 110,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  "Detail Transaksi",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6C4EFF)),
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
  final bool isBold;
  const _DetailRow(this.label, this.value, {this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(fontSize: 12, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isBold ? const Color(0xFF6C4EFF) : Colors.black)),
        ],
      ),
    );
  }
}
