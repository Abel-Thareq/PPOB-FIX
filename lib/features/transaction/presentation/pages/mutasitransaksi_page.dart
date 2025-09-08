import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'detailtransaksikirim_page.dart';
import 'detailtransaksiterima_page.dart';

class TransactionData {
  final String title;
  final String date;
  final double amount;

  TransactionData({
    required this.title,
    required this.date,
    required this.amount,
  });
}

class MutasiTransaksiPage extends StatelessWidget {
  const MutasiTransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      body: Column(
        children: [
          // Bagian Header
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                // Gambar Latar Belakang SVG
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

                // Tombol Kembali
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

                // Title dan Subtitle
                const Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        "modipay",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "SATU PINTU SEMUA PEMBAYARAN",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Mutasi Card
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
                    child: const Text(
                      "Mutasi Transaksi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C4DF4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bagian Pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              children: [
                // Kotak Input Pencarian
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Transaksi',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 15,
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // Ikon Filter
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Color(0xFF757575),
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Daftar Transaksi
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildMonthSection(context, 'Agustus 2025', -150000, [
                    TransactionData(
                      title: 'Kirim ke MOH. MAKFI MU...',
                      date: '18 Agt 2025    15:27',
                      amount: -150000,
                    ),
                  ]),
                  _buildMonthSection(context, 'Juli 2025', 150000, [
                    TransactionData(
                      title: 'Isi Saldo dari BRI',
                      date: '08 Jul 2025    12:49',
                      amount: 150000,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSection(
    BuildContext context,
    String month,
    double totalAmount,
    List<TransactionData> transactions,
  ) {
    final isPositive = totalAmount >= 0;
    final formattedTotal = totalAmount
        .abs()
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1, thickness: 2, color: Color(0xFFEEEEEE)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                month,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                '${isPositive ? "+" : "-"}Rp$formattedTotal',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5938FB),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 2, color: Color(0xFFEEEEEE)),
        ...transactions.map(
          (transaction) => _buildTransactionItem(
            context,
            transaction.title,
            transaction.date,
            transaction.amount,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    String title,
    String date,
    double amount,
  ) {
    final isPositive = amount > 0;
    final formattedAmount = amount
        .abs()
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );

    return GestureDetector(
      onTap: () {
        if (isPositive) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailTransaksiTerimaPage(
                tanggal: date,
                idModipay: '0813****7404',
                namaPengirim: 'MOH MAKFI MUSTOFA',
                nominal: formattedAmount,
                idTransaksi: '2134567890987654',
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailTransaksiKirimPage(
                tanggal: date,
                idModipay: '0813****7404',
                namaPenerima: 'MOH MAKFI MUSTOFA',
                noRekening: '*******507',
                bank: 'BRI 1055',
                nominal: formattedAmount,
                idTransaksi: '2134567890987765',
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isPositive ? Icons.south : Icons.north,
                color: const Color.fromARGB(255, 0, 0, 0),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Transaction Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              '${isPositive ? "+" : "-"}Rp$formattedAmount',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5938FB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
