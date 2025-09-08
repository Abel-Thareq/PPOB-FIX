import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/cicilan/presentation/pages/cicilan_empat.dart';

// Halaman untuk menampilkan detail tagihan cicilan
class CicilanTigaPage extends StatefulWidget {
  final String selectedProviderName;
  final String selectedProviderAssetPath;
  final String nomorPelanggan;
  final int totalTagihan;
  final int biayaAdmin;
  final String namaPelanggan;
  final String jatuhTempo;
  final int angsuranKe;

  const CicilanTigaPage({
    super.key,
    required this.selectedProviderName,
    required this.selectedProviderAssetPath,
    required this.nomorPelanggan,
    required this.totalTagihan,
    required this.biayaAdmin,
    required this.namaPelanggan,
    required this.jatuhTempo,
    required this.angsuranKe,
  });

  @override
  State<CicilanTigaPage> createState() => _CicilanTigaPageState();
}

class _CicilanTigaPageState extends State<CicilanTigaPage> {
  // State untuk melacak apakah "Tambah Ke Daftar Tersimpan" aktif
  bool _isSavedListActive = false;

  // Fungsi untuk memformat mata uang ke format Rupiah
  String formatCurrency(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung total tagihan akhir
    final totalPembayaran = widget.totalTagihan + widget.biayaAdmin;
    final screenWidth = MediaQuery.of(context).size.width;

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
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          // Box "Tagihan" yang tumpang tindih
          Positioned(
            top: 110,
            left: (screenWidth - 150) / 2, // Posisi horizontal di tengah
            right: (screenWidth - 150) / 2,
            child: Container(
              width: 150,
              height: 50,
              alignment: Alignment.center,
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
                "Tagihan",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C4EFF),
                ),
              ),
            ),
          ),

          // Konten utama yang dapat digulir
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Bagian Total Tagihan di luar box
                const Text(
                  "Total Tagihan",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatCurrency(totalPembayaran),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C4EFF),
                  ),
                ),
                const SizedBox(height: 20),

                // Box "Tambah Ke Daftar Tersimpan"
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
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
                  child: SwitchListTile(
                    title: const Text(
                      "Tambah Ke Daftar Tersimpan",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    value: _isSavedListActive,
                    onChanged: (bool value) {
                      setState(() {
                        _isSavedListActive = value;
                      });
                    },
                    activeColor: const Color(0xFF6C4EFF),
                  ),
                ),
                const SizedBox(height: 20),

                // Box detail tagihan
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
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
                      _DetailRow("Sumber Dana", "ABEL THAREQ", value2: "081390147404"),
                      _DetailRow("Nama Pelanggan", widget.namaPelanggan),
                      _DetailRow("Nomor Pelanggan", widget.nomorPelanggan),
                      _DetailRow("Nama Produk", widget.selectedProviderName),
                      _DetailRow("Jatuh Tempo", widget.jatuhTempo),
                      _DetailRow("Angsuran Ke", widget.angsuranKe.toString()),
                      const Divider(height: 24, thickness: 1),
                      _DetailRow("Tagihan", formatCurrency(widget.totalTagihan)),
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
                              "Total Tagihan",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              formatCurrency(totalPembayaran),
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
              ],
            ),
          ),

          // Tombol "Bayar Sekarang" di bagian bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                text: 'Bayar Sekarang',
                onPressed: () {
                  // Tambahkan logika navigasi ke halaman pembayaran berikutnya
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CicilanEmpatPage(
                        selectedProviderName: widget.selectedProviderName,
                        nomorPelanggan: widget.nomorPelanggan,
                        totalTagihan: widget.totalTagihan,
                        biayaAdmin: widget.biayaAdmin,
                        namaPelanggan: widget.namaPelanggan,
                        jatuhTempo: widget.jatuhTempo,
                        angsuranKe: widget.angsuranKe,
                      ),
                    ),
                  );
                },
              ),
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
