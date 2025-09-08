import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:ppob_app/features/main_screen/main_screen.dart';

class TarikTunaiEmpatPage extends StatefulWidget {
  final String jalur;
  final int nominal;
  final int biayaAdmin;
  final int denda;
  final int total;

  const TarikTunaiEmpatPage({
    super.key,
    required this.jalur,
    required this.nominal,
    required this.biayaAdmin,
    required this.denda,
    required this.total,
  });

  @override
  State<TarikTunaiEmpatPage> createState() => _TarikTunaiEmpatPageState();
}

class _TarikTunaiEmpatPageState extends State<TarikTunaiEmpatPage> {
  bool isExpanded = false;
  int remainingTime = 270; // 4 menit 30 detik
  late String withdrawalCode; // Variabel untuk menyimpan kode penarikan yang digenerate

  @override
  void initState() {
    super.initState();
    // Generate kode penarikan 6 digit secara acak saat halaman pertama kali dibuat
    final random = Random();
    int min = 100000;
    int max = 999999;
    withdrawalCode = (min + random.nextInt(max - min)).toString();

    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        startTimer();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes Menit $remainingSeconds Detik';
  }

  Future<bool> _onWillPop() async {
    // Tekan tombol back Android
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const MainScreen()));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // Objek formatter untuk mata uang Rupiah
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F1F5),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final double headerHeight = constraints.maxHeight * 0.17;

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/header.png",
                    fit: BoxFit.cover,
                    height: headerHeight,
                  ),
                ),
                Positioned(
                  top: headerHeight * 0.42,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: headerHeight,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailSection(
                                    widget.jalur, formatCurrency.format(widget.total)),
                                const SizedBox(height: 16),
                                const Center(
                                  child: Text(
                                    "Kode Penarikan",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                _buildCodeSection(),
                                const SizedBox(height: 12),
                                const Divider(color: Color(0xFFE0E0E0)),
                                _buildPaymentDetails(formatCurrency.format(widget.total)),
                                const SizedBox(height: 10),
                                _buildInformationSection(),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        _buildVerticalActionButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailSection(String jalur, String total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sumber Dana",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          "081215633163",
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Jalur Tarik Tunai",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B45F1),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          jalur.split(' - ').first,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildCodeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          withdrawalCode, // Menggunakan kode yang di-generate
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            // Menyalin kode yang di-generate
            Clipboard.setData(ClipboardData(text: withdrawalCode));
            HapticFeedback.lightImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Kode disalin!"),
                duration: Duration(seconds: 1),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFF3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.content_copy,
                color: Color(0xFF6B45F1), size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(String total) {
    return Column(
      children: [
        _buildDetailRow("Total Pembayaran", total),
        const Divider(color: Color(0xFFE0E0E0)),
        _buildDetailRow(
          "Batas Waktu Penarikan",
          formatTime(remainingTime),
          valueColor: remainingTime < 60 ? Colors.red : null,
        ),
        const Divider(color: Color(0xFFE0E0E0)),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F2F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12.0),
        title: Row(
          children: const [
            Icon(Icons.info_outline, color: Color(0xFF6B45F1), size: 18),
            SizedBox(width: 6),
            Text(
              "Informasi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (bool expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "• Pastikan saldo rekening Anda tersedia saat akan melakukan Tarik Tunai.",
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(height: 4),
                Text(
                  "• Pastikan Nominal yang diinput sama dengan Nominal ketersediaan dana yang akan di tarik di Merchant.",
                  style: TextStyle(fontSize: 11),
                ),
                SizedBox(height: 4),
                Text(
                  "• Pastikan nomor handphone yang Anda berikan ke Merchant terdaftar di modipay.",
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B45F1),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              _showCancelConfirmation();
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            child: const Text(
              "Batalkan Pesanan",
              style: TextStyle(
                color: Color(0xFF6B45F1),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCancelConfirmation() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Apakah anda yakin untuk membatalkan penarikan?",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Tidak"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Penarikanmu berhasil dibatalkan!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B45F1),
                      ),
                      child: const Text("Iya"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
