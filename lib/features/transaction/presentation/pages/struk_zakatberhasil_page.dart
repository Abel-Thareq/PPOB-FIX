import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class StrukZakatBerhasilPage extends StatelessWidget {
  final String noRef;
  final Map<String, dynamic> transactionData;
  final DateTime tanggal;

  const StrukZakatBerhasilPage({
    super.key,
    required this.noRef,
    required this.transactionData,
    required this.tanggal,
  });

  String _formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String nominalString = transactionData['nominal']?.toString() ?? '0';
    nominalString = nominalString
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .trim();
    final int nominalValue = int.tryParse(nominalString) ?? 0;
    const int biayaAdmin = 1000;
    final int total = nominalValue + biayaAdmin;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header Section with Background
          SizedBox(
            height: 150,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              fit: BoxFit.cover,
            ),
          ),

          // Back Button
          Positioned(
            left: 16,
            top: 51,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Header Text
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "modipay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "SATU PINTU SEMUA PEMBAYARAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Success Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Transaksi Berhasil",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // Transaction Details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          "Tanggal",
                          "${DateFormat('dd MMM yyyy').format(tanggal)} ${DateFormat('HH:mm:ss').format(tanggal)} WIB",
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow("No. Ref", noRef),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        _buildDetailRow("Sumber Dana", "ABEL THAREQ"),
                        Padding(
                          padding: const EdgeInsets.only(left: 230),
                          child: Text(
                            "081390147404",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow("Jenis Transaksi", "Zakat"),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          "Lembaga/Yayasan",
                          transactionData['zakatName'] ?? '',
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 12),
                        _buildDetailRow("Harga", _formatCurrency(nominalValue)),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          "Biaya Admin",
                          _formatCurrency(biayaAdmin),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Pembelian",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _formatCurrency(total),
                                style: const TextStyle(
                                  color: Color(0xFF6B48D1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  // Back Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B48D1),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Kembali",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
