import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:flutter/services.dart';

class IsiDepositPageTiga extends StatefulWidget {
  final Map<String, dynamic> selectedPayment; // Menerima seluruh data pembayaran
  final String? nominal; // Menerima data nominal dari halaman sebelumnya

  const IsiDepositPageTiga({
    super.key,
    required this.selectedPayment,
    this.nominal,
  });

  @override
  State<IsiDepositPageTiga> createState() => _IsiDepositPageTigaState();
}

class _IsiDepositPageTigaState extends State<IsiDepositPageTiga> {
  // Variabel untuk melacak status tampilan instruksi pembayaran
  bool showPaymentInstructions = false;

  // Fungsi navigasi yang akan digunakan oleh tombol kembali dan tombol kembali Android
  void _navigateToMainScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  // Fungsi untuk mendapatkan data detail pembayaran
  Map<String, String> _getPaymentDetails() {
    // Ini adalah data dummy yang bisa Abang ganti dengan data dinamis dari API
    return {
      'Jumlah Transfer': '${widget.nominal ?? '0'}',
      'Berita Transfer': 'DEP548226',
      'Nomor Rekening Tujuan': '010001002976560',
      'Nama Rekening': 'MODI TEKNO SOLUSINDO',
      'Waktu Tersisa': '59 Menit 30 Detik',
    };
  }

  // Widget untuk membuat baris informasi detail
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String paymentName = widget.selectedPayment['name'];
    String? iconPath = widget.selectedPayment['icon'];
    String shortName = widget.selectedPayment['shortName'];
    Map<String, String> paymentDetails = _getPaymentDetails();

    return WillPopScope(
      onWillPop: () async {
        _navigateToMainScreen();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // HEADER WITH IMAGE
            Stack(
              children: [
                Image.asset(
                  "assets/images/header.png",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 65,
                  left: 13,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _navigateToMainScreen,
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
                    // BANK BOX - Menampilkan ikon dan nama bank yang dipilih
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          if (iconPath != null)
                            Image.asset(iconPath, height: 28)
                          else
                            const Icon(Icons.account_balance, size: 28),
                          const SizedBox(width: 12),
                          Text(
                            paymentName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Center(
                      child: Text(
                        "Silakan menyelesaikan pembayaran sesuai keterangan berikut",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Box kode pembayaran
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C4EFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "DEP548226",
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
                              onTap: () {
                                Clipboard.setData(const ClipboardData(text: "DEP548226")).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Kode berhasil disalin")),
                                  );
                                });
                              },
                              child: Image.asset("assets/images/copy.png", height: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Detail Pembayaran
                    ...paymentDetails.keys.map((key) => _buildDetailRow(key, paymentDetails[key]!)).toList(),

                    const SizedBox(height: 24),

                    const Divider(height: 1, color: Colors.grey),
                    const SizedBox(height: 16),

                    // Payment Instructions Box
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                showPaymentInstructions = !showPaymentInstructions;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/rulepayment.png", height: 20),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: AutoSizeText(
                                      "Lihat tata cara pembayaran",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    showPaymentInstructions
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (showPaymentInstructions) ...[
                            const Divider(height: 1, color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pembayaran via ATM $shortName",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "1. Masukkan kartu & PIN ATM\n"
                                        "2. Pilih Menu Transaksi Lain → Pembayaran → Lainnya → ${shortName.toUpperCase()}\n"
                                        "3. Masukkan nomor akun virtual\n"
                                        "4. Masukkan jumlah deposit\n"
                                        "5. Pastikan jumlah sesuai tagihan\n"
                                        "6. Simpan struk bukti pembayaran",
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Pembayaran via M-Banking $shortName",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "1. Login M-Banking\n"
                                        "2. Pilih Menu Pembayaran\n"
                                        "3. Masukkan nomor akun virtual\n"
                                        "4. Masukkan jumlah deposit\n"
                                        "5. Pastikan jumlah sesuai tagihan\n"
                                        "6. Simpan bukti pembayaran",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tombol Kembali
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _navigateToMainScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C4EFF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
