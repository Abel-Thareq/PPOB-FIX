import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/pdam/presentation/pages/bayarpdam_pagetiga.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BayarPDAMPagedua extends StatefulWidget {
  final String nomorPelanggan;
  final String alamatWilayah;

  const BayarPDAMPagedua({
    super.key,
    required this.nomorPelanggan,
    required this.alamatWilayah,
  });

  @override
  State<BayarPDAMPagedua> createState() => _BayarPDAMPageduaState();
}

class _BayarPDAMPageduaState extends State<BayarPDAMPagedua> {
  bool isSaved = true;

  @override
  Widget build(BuildContext context) {
    const originalName = "PURXXXXXX";
    final maskedName = originalName;

    // Mengumpulkan semua data tagihan ke dalam sebuah Map
    final Map<String, String> billingDetails = {
      'Nama Pelanggan': 'PURXXXXXX',
      'Nomor Pelanggan': widget.nomorPelanggan,
      'Alamat': widget.alamatWilayah,
      'Periode Tagihan': 'Maret 2025',
      'Harga': 'Rp177.700',
      'Biaya Admin': 'Rp3.000',
      'Denda': 'Rp0',
      'Total Tagihan': 'Rp180.700',
    };

    return Scaffold(
      body: Column(
        children: [
          // HEADER
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 13.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PDAM Info Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/iconpdam.png',
                              width: 36,
                              height: 36,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maskedName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const Text(
                                  'Tagihan PDAM',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  widget.nomorPelanggan,
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Switch Save Box menggunakan ListTile dengan font lebih kecil
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tambah Ke Daftar Tersimpan',
                                style: TextStyle(
                                  fontSize: 13, // FONT DIKECILKAN DARI DEFAULT
                                  color: Colors.grey[700],
                                ),
                              ),
                              Switch(
                                value: isSaved,
                                onChanged: (value) {
                                  setState(() {
                                    isSaved = value;
                                  });
                                },
                                activeColor: const Color(0xFF6C4EFF),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Detail Info Box
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildDetailRow('Nama Pelanggan', 'PURXXXXXX'),
                              _buildDetailRow('Nomor Pelanggan', widget.nomorPelanggan),
                              _buildDetailRow('Alamat', widget.alamatWilayah),
                              _buildDetailRow('Periode Tagihan', 'Maret 2025'),
                              const Divider(),
                              _buildDetailRow('Harga', 'Rp177.700'),
                              _buildDetailRow('Biaya Admin', 'Rp3.000'),
                              _buildDetailRow('Denda', 'Rp0'),
                              const Divider(),
                              _buildDetailRow('Total Tagihan', 'Rp180.700',
                                  isBold: true, color: const Color(0xFF6C4EFF)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BUTTON KONFIRMASI
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Konfirmasi',
              onPressed: () {
                // Mengirim data billing ke halaman berikutnya
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BayarPdamPageTiga(billingDetails: billingDetails),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isBold = false, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
                label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600])),
          ),
          Expanded(
            child: AutoSizeText(
                value,
                textAlign: TextAlign.right,
                maxLines: 2,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    color: color)),
          ),
        ],
      ),
    );
  }
}