import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pin_tagihan_pendidikan_page.dart';
import '../../services/saved_transaction_service.dart';
import '../../models/saved_transaction.dart';

class TagihanPendidikanPage extends StatefulWidget {
  final String tanggal;
  final String idModipay;
  final String namaPengirim;
  final String nominal;
  final String idTransaksi;

  const TagihanPendidikanPage({
    super.key,
    required this.tanggal,
    required this.idModipay,
    required this.namaPengirim,
    required this.nominal,
    required this.idTransaksi,
  });

  @override
  State<TagihanPendidikanPage> createState() => _TagihanPendidikanPageState();
}

class _TagihanPendidikanPageState extends State<TagihanPendidikanPage> {
  bool _isSaved = false;
  final _transactionService = SavedTransactionService();

  Future<void> _saveTransaction() async {
    final transaction = SavedTransaction(
      id: widget.idTransaksi,
      name: widget.namaPengirim,
      customerNumber: widget.idModipay,
      date: DateTime.now(),
    );
    await _transactionService.saveTransaction(transaction);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaksi berhasil disimpan'),
          backgroundColor: Color(0xFF6C4DF4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildTotalTagihanSection(),
            const SizedBox(height: 12),
            _buildSaveToListCard(),
            const SizedBox(height: 12),
            _buildPaymentDetailsCard(),
            _buildFooterButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          // Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/images/backgroundtop.svg",
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          // Back Button
          Positioned(
            left: 16,
            top: 51,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Title
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "modipay",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "SATU PINTU SEMUA PEMBAYARAN",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Header Card
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Tagihan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C4DF4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalTagihanSection() {
    return Column(
      children: [
        const Text(
          "Total Tagihan",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFFA5A5A5),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Rp${widget.nominal}",
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C4DF4),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveToListCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Tambah Ke Daftar Tersimpan",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: _isSaved,
            onChanged: (bool value) {
              setState(() {
                _isSaved = value;
              });
              if (value) {
                _saveTransaction();
              }
            },
            activeTrackColor: const Color(0xFF6C4DF4),
            trackColor: WidgetStateProperty.all(const Color(0xFFEEEEEE)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Sumber Dana", "ABEL THAREQ", "081215633163"),
          _buildInfoRow("Nama Mahasiswa", "ALFIN CHIPMUNK"),
          _buildInfoRow("Nomor Induk Mahasiswa", "2220501077"),
          _buildInfoRow("Nama Produk", "Bayar UKT"),
          _buildInfoRow("Jatuh Tempo", "02 Mei 2025"),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFEEEEEE), height: 1, thickness: 1),
          const SizedBox(height: 16),
          _buildInfoRow("Tagihan", "Rp${widget.nominal}"),
          _buildInfoRow("Biaya Admin", "Rp0"),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Tagihan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6C4DF4),
                  ),
                ),
                Text(
                  "Rp${widget.nominal}",
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6C4DF4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, [String? subValue]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                if (subValue != null)
                  Text(
                    subValue,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ElevatedButton(
        onPressed: () {
          // Navigasi ke halaman PIN
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PinTagihanPendidikanPage(
                nomorInduk: "2220501077", // Ganti dengan data yang sesuai
                namaSiswa: "ALFIN CHIPMUNK", // Ganti dengan data yang sesuai
                harga: widget.nominal,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C4DF4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Bayar Sekarang",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
