import 'package:flutter/material.dart';
import 'package:ppob_app/features/listrik/presentation/pages/ProdukListrik_page.dart'; // pastikan path benar

class TokenListrikLimaPage extends StatelessWidget {
  const TokenListrikLimaPage({super.key});

  void _goBackToProduk(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ListrikProdukPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _goBackToProduk(context); // tangani tombol fisik back
        return false; // cegah default pop
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
                                        "6728 3746 1278 7029 1169",
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
                              const Text("No. Ref: 877924005731",
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
                              Image.asset('assets/images/iconpln.png', width: 36, height: 36),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("PONPES ASSALAFIYYAH 2",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 2),
                                    Text("Token Listrik",
                                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    Text("521041373414 - S1 / 5500 VA",
                                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1, thickness: 0.5),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                          child: Column(
                            children: [
                              _DetailRow("NO METER", "86035820385"),
                              _DetailRow("IDPEL", "521041373414"),
                              _DetailRow("NAMA", "PONPES ASSALAFIYYAH 2"),
                              _DetailRow("TARIF/DAYA", "S1 / 5500 VA"),
                              _DetailRow("NO REF", "200127283FE873 / 34E98B344AF48F8"),
                              Divider(height: 12),
                              _DetailRow("RP BAYAR", "Rp503.000"),
                              _DetailRow("MATERAI", "Rp0"),
                              _DetailRow("PPN", "Rp0"),
                              _DetailRow("PBJ+TL", "37.038,00"),
                              _DetailRow("ANGSURAN", "Rp0"),
                              _DetailRow("RP STROOM/TOKEN", "Rp373.038"),
                              _DetailRow("JML KWH", "Rp645,6"),
                              Divider(height: 12),
                              _DetailRow("NOMINAL", "Rp500.000"),
                              _DetailRow("ADMIN BANK", "Rp3.000"),
                              Divider(height: 12),
                              _DetailRow("Total Transaksi", "Rp503.000", isBold: true),
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
                  onPressed: () => _goBackToProduk(context),
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
