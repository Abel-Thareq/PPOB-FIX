import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/bpjs/presentation/pages/bpjs_page.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class TagihanBpjsTigaBerhasilPage extends StatefulWidget {
  final int totalPesanan;
  final int biayaAdmin;
  final String jenisBpjs;
  final String nomorPembayaran;

  const TagihanBpjsTigaBerhasilPage({
    super.key,
    required this.totalPesanan,
    required this.biayaAdmin,
    required this.jenisBpjs,
    required this.nomorPembayaran,
  });

  @override
  State<TagihanBpjsTigaBerhasilPage> createState() => _TagihanBpjsTigaBerhasilPageState();
}

class _TagihanBpjsTigaBerhasilPageState extends State<TagihanBpjsTigaBerhasilPage> {
  // Screenshot controller
  final ScreenshotController screenshotController = ScreenshotController();
  late String noRef; // Variabel untuk menyimpan nomor referensi

  @override
  void initState() {
    super.initState();
    // Generate nomor referensi random saat state diinisialisasi
    noRef = _generateReferenceNumber();
  }

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Method untuk generate nomor referensi random 20 digit
  String _generateReferenceNumber() {
    final random = Random();
    String reference = '';
    
    // Generate 20 digit angka random
    for (int i = 0; i < 20; i++) {
      reference += random.nextInt(10).toString();
    }
    
    return reference;
  }

  // Method untuk navigasi ke BpjsPage (sama seperti tombol Selesai)
  void _navigateToBpjsPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => BpjsPage(
          lastPaymentType: widget.jenisBpjs,
          lastPaymentNumber: widget.nomorPembayaran,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  // Method untuk menangani tombol back hardware Android
  Future<bool> _onWillPop() async {
    _navigateToBpjsPage();
    return false; // Mencegah pop default
  }

  // Method untuk capture dan share screenshot
  Future<void> _captureAndShare() async {
    try {
      // Tampilkan loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Capture screenshot
      final Uint8List? imageBytes = await screenshotController.capture(
        pixelRatio: 2.0,
        delay: const Duration(milliseconds: 300),
      );

      // Tutup loading indicator
      if (mounted) Navigator.of(context).pop();

      if (imageBytes != null) {
        // Share langsung dari bytes
        final xFile = XFile.fromData(
          imageBytes,
          name: 'bukti_bpjs_${DateTime.now().millisecondsSinceEpoch}.png',
          mimeType: 'image/png',
        );

        await Share.shareXFiles(
          [xFile],
          text: 'Bukti Pembayaran BPJS - $noRef', // Menggunakan variabel noRef
        );
      } else {
        // Fallback jika capture gagal
        _showFallbackShare();
      }
    } catch (e) {
      // Tutup loading indicator jika masih terbuka
      if (mounted) Navigator.of(context).pop();
      
      // Fallback ke share text saja
      _showFallbackShare();
    }
  }

  // Fallback method: share text saja
  void _showFallbackShare() {
    final totalTransaksi = widget.totalPesanan + widget.biayaAdmin;
    
    final shareText = '''
🏥 BUKTI PEMBAYARAN BPJS

📅 ${DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.now())}
No. Ref: $noRef

📊 DETAIL TRANSAKSI:
Jenis BPJS: ${widget.jenisBpjs}
Nomor Pembayaran: ${widget.nomorPembayaran}
Nama Pelanggan: ABEL THAREQ

💰 DETAIL PEMBAYARAN:
Harga: ${formatCurrency(widget.totalPesanan)}
Biaya Admin: ${formatCurrency(widget.biayaAdmin)}
TOTAL: ${formatCurrency(totalTransaksi)}

ID Transaksi: 971411A3FF0B8A45
Sumber Dana: AKMAL - 081234567890
''';

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final totalTransaksi = widget.totalPesanan + widget.biayaAdmin;

    // Menggunakan data dari parameter, bukan hardcode
    final String tanggalWaktu = DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.now());
    const String sumberDanaNama = "AKMAL";
    const String sumberDanaNomor = "081234567890";
    const String idTransaksi = "971411A3FF0B8A45";
    const String namaPelanggan = "ABEL THAREQ";

    return WillPopScope(
      onWillPop: _onWillPop, // Menangani tombol back hardware Android
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8FF),
        body: Stack(
          children: [
            // Header Background Image
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),

            // Tombol kembali di atas header
            Positioned(
              top: 10,
              left: 16,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  iconSize: 28,
                  onPressed: _navigateToBpjsPage, // Menggunakan fungsi yang sama dengan tombol Selesai
                ),
              ),
            ),

            // Konten utama yang dapat digulir
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 140, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon ceklis dan teks "Transaksi Berhasil" (TIDAK termasuk dalam screenshot)
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

                  // Area yang akan di-screenshot (hanya detail transaksi)
                  Screenshot(
                    controller: screenshotController,
                    child: Container(
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
                          _DetailRow("No. Ref", noRef), // Menggunakan variabel noRef
                          const Divider(height: 24, thickness: 1),
                          _DetailRow("Sumber Dana", sumberDanaNama, value2: sumberDanaNomor),
                          _DetailRow("Jenis Transaksi", "Pembayaran BPJS"),
                          _DetailRow("Nomor Pembayaran", widget.nomorPembayaran),
                          _DetailRow("ID Transaksi", idTransaksi),
                          _DetailRow("Nama Pelanggan", namaPelanggan),
                          const Divider(height: 24, thickness: 1),
                          _DetailRow("Harga", formatCurrency(widget.totalPesanan)),
                          _DetailRow("Biaya Admin", formatCurrency(widget.biayaAdmin)),
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
                  ),

                  // Text "Diamankan oleh Modipay" (TIDAK termasuk dalam screenshot)
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Diamankan oleh Modipay",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                  Row(
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
                            onPressed: _navigateToBpjsPage, // Menggunakan fungsi yang sama
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