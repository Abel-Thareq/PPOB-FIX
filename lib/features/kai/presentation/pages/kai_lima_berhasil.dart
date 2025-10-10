import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:ppob_app/features/main_screen/main_screen.dart';

class KaiLimaBerhasil extends StatefulWidget {
  final int nominalTagihan;
  final int biayaAdmin;
  final String namaPelanggan;
  final String kodeBayar;

  const KaiLimaBerhasil({
    super.key,
    required this.nominalTagihan,
    required this.biayaAdmin,
    required this.namaPelanggan,
    required this.kodeBayar,
  });

  @override
  State<KaiLimaBerhasil> createState() => _KaiLimaBerhasilState();
}

class _KaiLimaBerhasilState extends State<KaiLimaBerhasil> {
  // Screenshot controller
  final ScreenshotController screenshotController = ScreenshotController();
  late String noRef;
  bool _showDetails = false;
  final GlobalKey _screenshotKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    noRef = _generateRandomString(20);
  }

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

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
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

      // Build struk untuk screenshot (selalu expanded)
      final receiptForScreenshot = _buildReceiptForScreenshot();

      // Capture screenshot
      final Uint8List? imageBytes = await screenshotController.captureFromWidget(
        receiptForScreenshot,
        context: context,
        pixelRatio: 2.0,
        delay: const Duration(milliseconds: 300),
      );

      // Tutup loading indicator
      if (mounted) Navigator.of(context).pop();

      if (imageBytes != null) {
        // Share langsung dari bytes
        final xFile = XFile.fromData(
          imageBytes,
          name: 'bukti_kai_${DateTime.now().millisecondsSinceEpoch}.png',
          mimeType: 'image/png',
        );

        await Share.shareXFiles(
          [xFile],
          text: 'Bukti Pembayaran KAI - $noRef',
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
    final totalPembelian = widget.nominalTagihan + widget.biayaAdmin;
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';

    final shareText = '''
🚆 BUKTI PEMBAYARAN KAI

📅 $formattedDate
No. Ref: $noRef

📊 DETAIL TRANSAKSI:
Jenis Transaksi: Bayar KAI
Nama Pelanggan: ${widget.namaPelanggan}
Nomor Pelanggan: ${widget.kodeBayar}
Stasiun Asal: Lempuyangan (LPY)
Stasiun Tujuan: Pasar Senen (PSE)
Tanggal: 20 Agustus 2026
Waktu: 09:24
Jumlah Tempat Duduk: 1
Kursi: EKO-17A

💰 DETAIL PEMBAYARAN:
Harga: ${formatCurrency(widget.nominalTagihan)}
Denda: ${formatCurrency(0)}
Biaya Admin: ${formatCurrency(widget.biayaAdmin)}
TOTAL: ${formatCurrency(totalPembelian)}

Sumber Dana: ${widget.namaPelanggan}
''';

    Share.share(shareText);
  }

  // Widget untuk struk yang SELALU menampilkan detail lengkap (untuk screenshot)
  Widget _buildReceiptForScreenshot() {
    final totalPembelian = widget.nominalTagihan + widget.biayaAdmin;
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';

    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width - 48, // Sesuaikan dengan padding
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
            _DetailRow("Jenis Transaksi", "Bayar KAI"),
            _DetailRow("Nama Pelanggan", widget.namaPelanggan),
            _DetailRow("Nomor Pelanggan", widget.kodeBayar),
            
            // SELALU tampilkan detail lengkap untuk screenshot
            const SizedBox(height: 16),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 16),
            
            // Detail tiket KAI
            _DetailRow("Kode Pembayaran", "9901234567890"),
            _DetailRow("Stasiun Asal", "Lempuyangan (LPY)"),
            _DetailRow("Stasiun Tujuan", "Pasar Senen (PSE)"),
            _DetailRow("Tanggal", "20 Agustus 2026"),
            _DetailRow("Waktu", "09:24"),
            _DetailRow("Jumlah Tempat Duduk", "1"),
            _DetailRow("Kursi", "EKO-17A"),
            
            const SizedBox(height: 16),
            const Divider(height: 1, color: Colors.grey),
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
    );
  }

  // Widget untuk struk yang dilihat user (bisa expand/collapse)
  Widget _buildReceiptForDisplay() {
    final totalPembelian = widget.nominalTagihan + widget.biayaAdmin;
    final now = DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(now) + ' WIB';

    return Container(
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
          _DetailRow("Jenis Transaksi", "Bayar KAI"),
          _DetailRow("Nama Pelanggan", widget.namaPelanggan),
          _DetailRow("Nomor Pelanggan", widget.kodeBayar),
          
          // Tombol Lihat Detail Transaksi
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: _toggleDetails,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _showDetails ? "Sembunyikan Detail" : "Lihat Detail Transaksi",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6C4EFF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _showDetails ? Icons.expand_less : Icons.expand_more,
                      size: 16,
                      color: const Color(0xFF6C4EFF),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Detail tambahan yang bisa di-expand
          if (_showDetails) ...[
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 16),
            
            // Detail tiket KAI
            _DetailRow("Kode Pembayaran", "9901234567890"),
            _DetailRow("Stasiun Asal", "Lempuyangan (LPY)"),
            _DetailRow("Stasiun Tujuan", "Pasar Senen (PSE)"),
            _DetailRow("Tanggal", "20 Agustus 2026"),
            _DetailRow("Waktu", "09:24"),
            _DetailRow("Jumlah Tempat Duduk", "1"),
            _DetailRow("Kursi", "EKO-17A"),
            
            const SizedBox(height: 16),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 16),
          ],
          
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
    );
  }

  @override
  Widget build(BuildContext context) {
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
            // Konten utama - HANYA SATU STRUK YANG DITAMPILKAN
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 140, bottom: 20, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon sukses
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
                  const SizedBox(height: 16),
                  
                  // HANYA SATU STRUK YANG DITAMPILKAN
                  _buildReceiptForDisplay(),
                  
                  // Text diamankan oleh Modipay
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
                  
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _captureAndShare,
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
            // HEADER dan TOMBOL
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
            // Tombol back dengan area tap yang lebih besar
            Positioned(
              top: 43,
              left: 19,
              child: Container(
                decoration: BoxDecoration(
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