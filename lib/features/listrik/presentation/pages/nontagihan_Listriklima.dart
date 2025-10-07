import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ppob_app/features/listrik/presentation/pages/ProdukListrik_page.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class NonTagihanListriklima extends StatefulWidget {
  final String customerName;
  final String meterNumber;
  final String paymentMethod;
  final String? selectedBank;
  final int totalPesanan;
  final int voucherDiscount;
  final int biayaAdmin;
  final int totalPembayaran;
  final String selectedVoucher;

  const NonTagihanListriklima({
    Key? key,
    required this.customerName,
    required this.meterNumber,
    required this.paymentMethod,
    this.selectedBank,
    required this.totalPesanan,
    required this.voucherDiscount,
    required this.biayaAdmin,
    required this.totalPembayaran,
    required this.selectedVoucher,
  }) : super(key: key);

  @override
  State<NonTagihanListriklima> createState() => _NonTagihanListriklimaState();
}

class _NonTagihanListriklimaState extends State<NonTagihanListriklima> {
  // Screenshot controller
  final ScreenshotController screenshotController = ScreenshotController();

  void _goBackToProduk(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ListrikProdukPage()),
    );
  }

  // Method untuk format currency
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // Method untuk mendapatkan timestamp saat ini
  String getCurrentTimestamp() {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd MMM yyyy   HH:mm');
    return dateFormat.format(now);
  }

  // Method untuk generate nomor referensi acak
  String generateReferenceNumber() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return '${random.toString().substring(0, 12)}';
  }

  // Method untuk extract nomor meter dari meterNumber
  String _extractMeterNumber(String meterInfo) {
    if (meterInfo.contains(' - ')) {
      return meterInfo.split(' - ')[0];
    }
    return meterInfo;
  }

  // Method untuk extract IDPEL (sama dengan nomor meter)
  String _extractIdPel(String meterInfo) {
    return _extractMeterNumber(meterInfo);
  }

  // Method untuk extract tarif/daya
  String _extractTarifDaya(String meterInfo) {
    if (meterInfo.contains(' - ')) {
      return meterInfo.split(' - ')[1];
    }
    return meterInfo;
  }

  // Method untuk capture dan share screenshot - SIMPLIFIED VERSION
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
        // Method 1: Share langsung dari bytes (tanpa simpan file)
        final xFile = XFile.fromData(
          imageBytes,
          name: 'bukti_nontagihan_listrik_${DateTime.now().millisecondsSinceEpoch}.png',
          mimeType: 'image/png',
        );

        await Share.shareXFiles(
          [xFile],
          text: 'Bukti Pembayaran Non-Tagihan Listrik - ${generateReferenceNumber()}',
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
    final shareText = '''
⚡ BUKTI PEMBAYARAN NON-TAGIHAN LISTRIK

📅 ${getCurrentTimestamp()}
✅ Transaksi Berhasil

📊 DETAIL TRANSAKSI:
No. Ref: ${generateReferenceNumber()}
Nama: ${widget.customerName}
No. Meter: ${_extractMeterNumber(widget.meterNumber)}
Tarif/Daya: ${_extractTarifDaya(widget.meterNumber)}

💰 DETAIL PEMBAYARAN:
Total Pesanan: ${formatCurrency(widget.totalPesanan)}
${widget.voucherDiscount > 0 ? 'Diskon Voucher: -${formatCurrency(widget.voucherDiscount)}' : ''}
Biaya Admin: ${formatCurrency(widget.biayaAdmin)}
TOTAL: ${formatCurrency(widget.totalPembayaran)}

💳 Metode: ${widget.selectedBank ?? widget.paymentMethod}

Diamankan oleh Modipay
''';

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _goBackToProduk(context);
        return false;
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
                  // Area yang akan di-screenshot (tanpa tombol bagikan)
                  Screenshot(
                    controller: screenshotController,
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
                                              generateReferenceNumber(),
                                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.copy, size: 18),
                                            onPressed: () {
                                              // Implement copy to clipboard
                                            },
                                            padding: EdgeInsets.zero,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text("No. Ref: ${generateReferenceNumber()}",
                                        style: const TextStyle(fontSize: 11, color: Colors.grey)),
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.customerName,
                                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                                          ),
                                          const SizedBox(height: 2),
                                          const Text(
                                            "Non-Tagihan Listrik",
                                            style: TextStyle(fontSize: 12, color: Colors.grey)
                                          ),
                                          Text(
                                            widget.meterNumber,
                                            style: const TextStyle(fontSize: 12, color: Colors.grey)
                                          ),
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
                                  children: [
                                    // Informasi Pembayaran dari Page 3
                                    _DetailRow("METODE PEMBAYARAN", widget.selectedBank ?? widget.paymentMethod),
                                    _DetailRow("TOTAL PESANAN", formatCurrency(widget.totalPesanan)),
                                    if (widget.voucherDiscount > 0)
                                      _DetailRow("DISKON VOUCHER", "-${formatCurrency(widget.voucherDiscount)}"),
                                    _DetailRow("BIAYA ADMIN", formatCurrency(widget.biayaAdmin)),
                                    const Divider(height: 12),
                                    _DetailRow("TOTAL PEMBAYARAN", formatCurrency(widget.totalPembayaran), isBold: true),

                                    // Informasi tambahan PLN - MENGGUNAKAN DATA YANG DITERIMA
                                    const Divider(height: 20),
                                    _DetailRow("NO METER", _extractMeterNumber(widget.meterNumber)),
                                    _DetailRow("IDPEL", _extractIdPel(widget.meterNumber)),
                                    _DetailRow("NAMA", widget.customerName),
                                    _DetailRow("TARIF/DAYA", _extractTarifDaya(widget.meterNumber)),
                                    _DetailRow("NO REF", generateReferenceNumber()),
                                    const Divider(height: 12),
                                    _DetailRow("RP BAYAR", formatCurrency(widget.totalPembayaran)),
                                    _DetailRow("MATERAI", "Rp0"),
                                    _DetailRow("PPN", "Rp0"),
                                    _DetailRow("PBJ+TL", formatCurrency(widget.totalPesanan)),
                                    _DetailRow("ANGSURAN", "Rp0"),
                                    _DetailRow("RP STROOM/TOKEN", formatCurrency(widget.totalPesanan)),
                                    _DetailRow("JML KWH", "645,6"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Text "Diamankan oleh Modipay" termasuk dalam screenshot
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text("Diamankan oleh Modipay", style: TextStyle(color: Colors.grey, fontSize: 11)),
                        ),
                      ],
                    ),
                  ),

                  // Tombol Bagikan (TIDAK termasuk dalam screenshot)
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
                        onPressed: _captureAndShare,
                        child: const Text(
                          "Bagikan",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
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
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? const Color(0xFF6C4EFF) : Colors.black
            ),
          ),
        ],
      ),
    );
  }
}