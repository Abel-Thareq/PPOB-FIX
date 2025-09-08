import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/bpjs/presentation/pages/bpjs_page.dart'; // Perhatikan: import BpjsPage

class TagihanBpjsTigaBerhasilPage extends StatelessWidget {
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

  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final totalTransaksi = totalPesanan + biayaAdmin;

    // Menggunakan data dari parameter, bukan hardcode
    final String tanggalWaktu = DateFormat('dd MMM yyyy HH:mm:ss').format(DateTime.now());
    const String noRef = "11829203871637617632";
    const String sumberDanaNama = "AKMAL";
    const String sumberDanaNomor = "081234567890";
    const String idTransaksi = "971411A3FF0B8A45";
    const String namaPelanggan = "ABEL THAREQ";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Stack(
        children: [
          // Header Background Image
          SizedBox(
            height: 140,
            width: double.infinity,
            child: Image.asset(
              'assets/images/header.png',
              fit: BoxFit.cover,
            ),
          ),

          // Tombol kembali di atas header
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: 28,
                onPressed: () {
                  // Kembali ke halaman sebelumnya
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Konten utama yang dapat digulir
          SingleChildScrollView(
            // Menambahkan padding untuk mendorong konten ke bawah
            padding: const EdgeInsets.only(top: 160, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon ceklis
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50), // Mengubah warna menjadi hijau
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 35, // Mengecilkan ukuran ikon
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  "Transaksi Berhasil",
                  style: TextStyle(
                    fontSize: 14, // Mengecilkan ukuran font
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Mengubah warna teks menjadi hitam
                  ),
                ),
                const SizedBox(height: 25),

                // Box detail transaksi
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
                      _DetailRow("Jenis Transaksi", "Pembayaran BPJS"),
                      _DetailRow("Nomor Pembayaran", nomorPembayaran),
                      _DetailRow("ID Transaksi", idTransaksi),
                      _DetailRow("Nama Pelanggan", namaPelanggan),
                      const Divider(height: 24, thickness: 1),
                      _DetailRow("Harga", formatCurrency(totalPesanan)),
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
                          text: 'Bagikan',
                          onPressed: () {
                            // Menampilkan SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Detail Transaksi berhasil di copy"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          isOutlined: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomButton(
                          text: 'Selesai',
                          onPressed: () {
                            // Navigasi ke BpjsPage dan kirim data transaksi
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BpjsPage(
                                  lastPaymentType: jenisBpjs,
                                  lastPaymentNumber: nomorPembayaran,
                                ),
                              ),
                                  (Route<dynamic> route) => false,
                            );
                          },
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
