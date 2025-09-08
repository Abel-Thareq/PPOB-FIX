import 'package:flutter/material.dart';
import 'package:ppob_app/features/Tarik%20Tunai/presentation/pages/tarik_tunaisatu.dart';
import 'package:ppob_app/features/Tarik%20Tunai/presentation/pages/tarik_tunaitiga.dart';
import 'package:intl/intl.dart';

class TarikTunaiDuaPage extends StatefulWidget {
  final String jalur;
  final int nominal;
  final String assetPath;

  const TarikTunaiDuaPage({
    super.key,
    required this.jalur,
    required this.nominal,
    required this.assetPath,
  });

  @override
  State<TarikTunaiDuaPage> createState() => _TarikTunaiDuaPageState();
}

class _TarikTunaiDuaPageState extends State<TarikTunaiDuaPage> {
  @override
  Widget build(BuildContext context) {
    int biayaAdmin = 3000;
    int denda = 0;
    int total = widget.nominal + biayaAdmin + denda;

    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/header.png",
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TarikTunaiSatuPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sumber Dana",
                    style: TextStyle(
                      color: Color(0xFF6245FC),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6245FC),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            "AT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ABEL THAREQ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "modipay - 081215633163",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Jalur Tarik Tunai",
                    style: TextStyle(
                      color: Color(0xFF6245FC),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          widget.assetPath,
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 12),
                        Text(widget.jalur),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Detail",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.jalur.split(" - ").first,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              _buildDetailRow(
                                  "Harga", formatCurrency.format(widget.nominal)),
                              const SizedBox(height: 8),
                              _buildDetailRow("Biaya Admin",
                                  formatCurrency.format(biayaAdmin)),
                              const SizedBox(height: 8),
                              _buildDetailRow("Denda", formatCurrency.format(denda)),
                              const SizedBox(height: 12),
                              _buildDetailRow(
                                  "Total", formatCurrency.format(total),
                                  isTotal: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TarikTunaiTigaPage(
                              jalur: widget.jalur,
                              nominal: widget.nominal,
                              biayaAdmin: biayaAdmin,
                              denda: denda,
                              total: total,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6245FC),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Konfirmasi",
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? const Color(0xFF6245FC) : Colors.black,
          ),
        ),
      ],
    );
  }
}
