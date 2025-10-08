import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ppob_app/features/pdam/presentation/pages/pdam_page.dart';
import 'dart:async'; // Import library untuk Timer
import 'package:flutter/services.dart'; // Import untuk Clipboard

class BayarPdamPageLima extends StatefulWidget {
  final String bankName;
  final String totalAmount;

  const BayarPdamPageLima({
    super.key,
    required this.bankName,
    required this.totalAmount,
  });

  @override
  State<BayarPdamPageLima> createState() => _BayarPdamPageLimaState();
}

class _BayarPdamPageLimaState extends State<BayarPdamPageLima> {
  bool showPaymentInstructions = false;
  late Timer _timer;
  late Duration _countdown;

  // Fungsi helper untuk mendapatkan path ikon bank
  String? _getBankIconPath(String bankName) {
    switch (bankName) {
      case "Bank BRI":
        return "assets/images/iconbri.png";
      case "Bank BCA":
        return "assets/images/iconbca.png";
      case "Bank MANDIRI":
        return "assets/images/iconmandiri.png";
      case "Bank BNI":
        return "assets/images/iconbni.png";
      case "Bank Syariah Indonesia":
        return "assets/images/iconbsi.png";
      default:
        return null;
    }
  }

  // Fungsi untuk format durasi menjadi string
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours Jam $minutes Menit $seconds Detik";
  }

  // Fungsi untuk copy ke clipboard
  void _copyToClipboard() {
    Clipboard.setData(const ClipboardData(text: "88810085377642239"));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Nomor Virtual Account berhasil disalin"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi countdown 24 jam
    _countdown = const Duration(hours: 24);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown.inSeconds > 0) {
          _countdown = _countdown - const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Pastikan timer dibatalkan saat widget dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? bankIconPath = _getBankIconPath(widget.bankName);
    String bankShortName = widget.bankName.split(" ")[1];

    return WillPopScope(
      onWillPop: () async {
        // Arahkan ke PdamPage ketika tombol back ditekan
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PdamPage()),
        );
        return false; // Return false untuk mencegah default back behavior
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // HEADER WITH IMAGE - UKURAN DIPERKECIL
            Stack(
              children: [
                Image.asset(
                  "assets/images/header.png",
                  width: double.infinity,
                  height: 120, // DIKECILKAN DARI 150 MENJADI 120
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 13.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PdamPage()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BANK BOX
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          if (bankIconPath != null)
                            Image.asset(bankIconPath, height: 28)
                          else
                            const Icon(Icons.account_balance, size: 28),
                          const SizedBox(width: 12),
                          Text(
                            widget.bankName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Virtual Account Title
                    const Center(
                      child: Text(
                        "No. Rek/Virtual Account",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6C4EFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Center(
                      child: Text(
                        "Nomor Akun Virtual",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nomor Virtual Account Box - DITAMBAH SHADOW
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C4EFF),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C4EFF).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "88810 0853 7764 2239",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                minFontSize: 10,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            InkWell(
                              onTap: _copyToClipboard,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Image.asset("assets/images/copy.png", height: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Total Pembayaran
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: AutoSizeText(
                            "Total Pembayaran",
                            style: TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AutoSizeText(
                          widget.totalAmount, // Menggunakan totalAmount dinamis
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Batas Waktu Pembayaran
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: AutoSizeText(
                            "Batas Waktu Pembayaran",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        AutoSizeText(
                          _formatDuration(_countdown), // Menggunakan countdown dinamis
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: AutoSizeText(
                        "Jatuh tempo 10 Mar 2025, 10:13",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Divider(height: 1, color: Colors.grey),
                    const SizedBox(height: 16),

                    // Payment Instructions Box - DIREVISI
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Header Box
                          InkWell(
                            onTap: () {
                              setState(() {
                                showPaymentInstructions = !showPaymentInstructions;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.vertical(
                                  top: const Radius.circular(12),
                                  bottom: showPaymentInstructions 
                                      ? Radius.zero 
                                      : const Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Icon tanpa background ungu
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Image.asset(
                                      "assets/images/rulepayment.png", 
                                      height: 20,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Center(
                                      child: Text(
                                        "Lihat tata cara pembayaran",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Panah tanpa background
                                  Icon(
                                    showPaymentInstructions
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.grey.shade700,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          // Content Box
                          if (showPaymentInstructions) ...[
                            const Divider(height: 1, color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ATM Section
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF6C4EFF),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: const Icon(
                                                Icons.atm,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "Pembayaran via ATM $bankShortName",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF6C4EFF),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        _buildInstructionStep("1. Masukkan kartu & PIN ATM"),
                                        _buildInstructionStep("2. Pilih Menu Transaksi Lain → Pembayaran → Lainnya → BRIVA"),
                                        _buildInstructionStep("3. Masukkan nomor akun virtual BRI"),
                                        _buildInstructionStep("4. Masukkan jumlah top up"),
                                        _buildInstructionStep("5. Pastikan jumlah sesuai tagihan"),
                                        _buildInstructionStep("6. Simpan struk bukti pembayaran"),
                                      ],
                                    ),
                                  ),

                                  // Mobile Banking Section
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF6C4EFF),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: const Icon(
                                                Icons.phone_iphone,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "Pembayaran via BRIMO ($bankShortName)",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF6C4EFF),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        _buildInstructionStep("1. Login BRIMO"),
                                        _buildInstructionStep("2. Pilih Tambah transaksi baru"),
                                        _buildInstructionStep("3. Masukkan nomor akun virtual BRI"),
                                        _buildInstructionStep("4. Masukkan jumlah top up"),
                                        _buildInstructionStep("5. Pastikan jumlah sesuai tagihan"),
                                        _buildInstructionStep("6. Simpan struk bukti pembayaran"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  // Widget helper untuk membuat step instruksi - DIREVISI
  Widget _buildInstructionStep(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}