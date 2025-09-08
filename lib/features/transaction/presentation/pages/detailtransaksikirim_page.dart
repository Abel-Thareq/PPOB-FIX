import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailTransaksiKirimPage extends StatelessWidget {
  final String tanggal;
  final String idModipay;
  final String namaPenerima;
  final String noRekening;
  final String bank;
  final String nominal;
  final String idTransaksi;

  const DetailTransaksiKirimPage({
    super.key,
    required this.tanggal,
    required this.idModipay,
    required this.namaPenerima,
    required this.noRekening,
    required this.bank,
    required this.nominal,
    required this.idTransaksi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTimestampSection(),
            _buildTransactionCard(),
            _buildShareButton(),
            _buildFooter(),
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
                  "Detail Transaksi",
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

  Widget _buildTimestampSection() {
    return const SizedBox.shrink(); // Removed as it's now part of transaction card
  }

  Widget _buildTransactionCard() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 16),
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              "assets/images/modipay.png",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tanggal,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Color(0xFF999999),
                  ),
                ),
                Text(
                  "ID Modipay $idModipay",
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 2,
            color: const Color(0xFFEEEEEE),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSuccessStatus(),
                const SizedBox(height: 16),
                _buildTransactionDetails(),
                const SizedBox(height: 16),
                _buildTotalPayment(),
                const SizedBox(height: 16),
                _buildInfoDetails(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStatus() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Color(0xFFE8FFF3),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_circle,
            color: Color(0xFF00D261),
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          "Transaksi Berhasil",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00D261),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kirim Uang Rp$nominal ke $namaPenerima-",
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "$bank $noRekening",
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalPayment() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF6C4DF4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total Bayar",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            "Rp$nominal",
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Info box and header removed as they're now part of transaction card

  Widget _buildInfoDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow("Harga", "Rp$nominal"),
        const SizedBox(height: 8),
        _buildInfoRow("Metode Pembayaran", "Saldo Modipay"),
        const SizedBox(height: 8),
        Container(height: 2, color: const Color(0xFFEEEEEE)),
        const SizedBox(height: 16),
        _buildSectionTitle("Detail Penerima"),
        const SizedBox(height: 8),
        _buildInfoRow("Nama", namaPenerima),
        const SizedBox(height: 8),
        _buildInfoRow("Akun Bank", "$bank $noRekening"),
        const SizedBox(height: 16),
        _buildSectionTitle("Detail Transaksi"),
        const SizedBox(height: 8),
        _buildInfoRow("ID Transaksi", idTransaksi),
        const SizedBox(height: 8),
        _buildInfoRow("ID Order Modipay", idModipay),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildShareButton() {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement share functionality
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C4DF4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Bagikan",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const SizedBox(height: 2),
        const Center(
          child: Text(
            "Diamankan Oleh Modipay",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Color(0xFFA5A5A5),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            color: Color(0xFF757575),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            color: Color(0xFF999999),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
