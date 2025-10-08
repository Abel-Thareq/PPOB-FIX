import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'dart:math';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class BayarPdamPageEnamBerhasil extends StatefulWidget {
  final Map<String, String> billingDetails;

  const BayarPdamPageEnamBerhasil({
    super.key,
    required this.billingDetails,
  });

  @override
  State<BayarPdamPageEnamBerhasil> createState() => _BayarPdamPageEnamBerhasilState();
}

class _BayarPdamPageEnamBerhasilState extends State<BayarPdamPageEnamBerhasil> {
  final ScreenshotController screenshotController = ScreenshotController();
  late String noRef;

  @override
  void initState() {
    super.initState();
    noRef = _generateRandomString(20);
  }

  String formatCurrency(String amount) {
    final cleanAmount = amount.replaceAll('Rp', '').replaceAll('.', '');
    final number = int.tryParse(cleanAmount) ?? 0;
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(number);
  }

  void _onBackPressed() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  String _generateRandomString(int length) {
    final random = Random();
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  String getCurrentTimestamp() {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd MMM yyyy   HH:mm');
    return dateFormat.format(now);
  }

  Future<void> _captureAndShare() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      final Uint8List? imageBytes = await screenshotController.capture(
        pixelRatio: 2.0,
        delay: const Duration(milliseconds: 300),
      );

      if (mounted) Navigator.of(context).pop();

      if (imageBytes != null) {
        final xFile = XFile.fromData(
          imageBytes,
          name: 'bukti_pembayaran_pdam_${DateTime.now().millisecondsSinceEpoch}.png',
          mimeType: 'image/png',
        );

        await Share.shareXFiles(
          [xFile],
          text: 'Bukti Pembayaran PDAM - $noRef',
        );
      } else {
        _showFallbackShare();
      }
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      _showFallbackShare();
    }
  }

  void _showFallbackShare() {
    final shareText = '''
💧 BUKTI PEMBAYARAN PDAM

📅 ${getCurrentTimestamp()}
✅ Transaksi Berhasil

📊 DETAIL TRANSAKSI:
No. Ref: $noRef
Nama: ${widget.billingDetails['Nama Pelanggan'] ?? 'Pelanggan PDAM'}
No. Pelanggan: ${widget.billingDetails['Nomor Pelanggan'] ?? ''}
Alamat: ${widget.billingDetails['Alamat'] ?? ''}
Periode: ${widget.billingDetails['Periode Tagihan'] ?? ''}

💰 DETAIL PEMBAYARAN:
Harga: ${widget.billingDetails['Harga']!}
Biaya Admin: ${widget.billingDetails['Biaya Admin']!}
Denda: ${widget.billingDetails['Denda']!}
TOTAL: ${widget.billingDetails['Total Tagihan']!}

💳 Metode: Modipay

Diamankan oleh Modipay
''';

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now);
    const sumberDanaNama = "AKMAL";
    const sumberDanaNomor = "081234567890";
    const idTransaksi = "971411A3FF0B8A45";
    final namaPelanggan = widget.billingDetails['Nama Pelanggan'] ?? 'Pelanggan PDAM';
    final nomorPelanggan = widget.billingDetails['Nomor Pelanggan'] ?? '';
    final totalTransaksi = widget.billingDetails['Total Tagihan']!;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Column(
          children: [
            // HEADER WITH IMAGE - SEPERTI DI BayarPdamPageLima
            Stack(
              children: [
                Image.asset(
                  "assets/images/header.png",
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 46,
                  left: 15,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _onBackPressed,
                  ),
                ),
              ],
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon ceklis dan teks Transaksi Berhasil (TIDAK termasuk dalam screenshot)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(50),
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Area yang akan di-screenshot (HANYA box detail transaksi)
                    Screenshot(
                      controller: screenshotController,
                      child: Column(
                        children: [
                          // Box detail transaksi SAJA yang di-screenshot
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
                                // Header dalam box untuk screenshot
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getCurrentTimestamp(),
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
                                      Expanded(
                                        child: Text(
                                          noRef,
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text("No. Ref: $noRef",
                                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                
                                const Divider(height: 24, thickness: 1),
                                _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                                _DetailRow("Jenis Transaksi", "Pembayaran PDAM"),
                                _DetailRow("Nomor Pelanggan", nomorPelanggan),
                                _DetailRow("ID Transaksi", idTransaksi),
                                _DetailRow("Nama Pelanggan", namaPelanggan),
                                const Divider(height: 24, thickness: 1),
                                _DetailRow("Harga", widget.billingDetails['Harga']!),
                                _DetailRow("Biaya Admin", widget.billingDetails['Biaya Admin']!),
                                _DetailRow("Denda", widget.billingDetails['Denda']!),
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
                                        totalTransaksi,
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
                          // Text "Diamankan oleh Modipay" termasuk dalam screenshot
                          const Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              "Diamankan oleh Modipay",
                              style: TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tombol Bagikan dan Selesai (TIDAK termasuk dalam screenshot)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomButton(
                                text: 'Bagikan',
                                onPressed: _captureAndShare,
                                isOutlined: true,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomButton(
                                text: 'Selesai',
                                onPressed: _onBackPressed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget pembantu untuk baris detail
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

// Widget placeholder untuk CustomButton
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
          foregroundColor: borderColor ?? const Color(0xFF6C4EFF),
          side: BorderSide(color: borderColor ?? const Color(0xFF6C4EFF)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? const Color(0xFF6C4EFF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: Text(text),
      );
    }
  }
}