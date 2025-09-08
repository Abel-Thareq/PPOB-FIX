import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart'; // Import MainScreen
import 'package:ppob_app/features/pbb/presentation/pages/pbb_page.dart'; // Import PbbPage

class PbbLimaGagalPage extends StatelessWidget {
  final int nominalBayar;
  final int denda;
  final int biayaAdmin;
  final String keterangan;
  final String lokasi;
  final String namaPelanggan;
  final String nomorObjekPajak;
  final String kabupaten;
  final String tahun;

  const PbbLimaGagalPage({
    super.key,
    required this.nominalBayar,
    required this.denda,
    required this.biayaAdmin,
    required this.keterangan,
    required this.lokasi,
    required this.namaPelanggan,
    required this.nomorObjekPajak,
    required this.kabupaten,
    required this.tahun,
  });

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final totalTransaksi = nominalBayar + denda + biayaAdmin;
    final String tanggalWaktu = DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.now());
    const String noRef = "11829203871637617632";
    const String sumberDanaNama = "ABEL THAREQ";
    const String sumberDanaNomor = "081390147404";

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 22.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            SizedBox(
              height: 140,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 160, bottom: 20),
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                        _DetailRow("Tanggal", tanggalWaktu),
                        _DetailRow("No. Ref", noRef),
                        const Divider(height: 24, thickness: 1),
                        _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                        _DetailRow("Jenis Transaksi", "Pembayaran PBB"),
                        _DetailRow("NOP Tujuan", nomorObjekPajak),
                        _DetailRow("Kabupaten/Kota", kabupaten),
                        _DetailRow("Tahun", tahun),
                        const Divider(height: 24, thickness: 1),
                        _DetailRow("Nominal Bayar", formatCurrency(nominalBayar)),
                        _DetailRow("Denda", formatCurrency(denda)),
                        _DetailRow("Biaya Admin", formatCurrency(biayaAdmin)),
                        const Divider(height: 24, thickness: 1),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
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
                                formatCurrency(totalTransaksi),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C4EFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomButton(
                            text: 'Kembali',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const MainScreen()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            isOutlined: true,
                            borderColor: Colors.red,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomButton(
                            text: 'Coba Lagi',
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const PbbPage()), // Navigate back to the PbbPage
                                (Route<dynamic> route) => false,
                              );
                            },
                            buttonColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
  final String? value2;

  const _DetailRow(this.label, this.value, {this.value2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              if (value2 != null)
                Text(
                  value2!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Color? buttonColor;
  final Color? borderColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.buttonColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: borderColor ?? Colors.black,
          side: BorderSide(color: borderColor ?? Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: Text(text),
      );
    }
  }
}
