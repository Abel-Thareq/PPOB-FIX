import 'package:flutter/material.dart';
import 'package:ppob_app/features/pdam/presentation/pages/bayarpdam_pagelima.dart';

class BayarPdamPageEmpat extends StatelessWidget {
  // Tambahkan properti untuk menerima data tagihan
  final Map<String, String> billingDetails;
  final String? bankName;

  const BayarPdamPageEmpat({
    super.key,
    required this.billingDetails,
    this.bankName,
  });

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

  @override
  Widget build(BuildContext context) {
    // Tentukan bank yang ditampilkan berdasarkan data yang diterima
    String bankShortName = bankName?.split(" ")[1] ?? "Modipay";
    String bankFullName = bankName ?? "Saldo Modipay";
    String? bankIconPath = bankName != null ? _getBankIconPath(bankName!) : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with back button
          Stack(
            children: [
              Image.asset(
                'assets/images/header.png',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              // Tombol back otomatis center secara vertikal
              Positioned.fill(
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bank Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (bankIconPath != null)
                        Image.asset(
                          bankIconPath,
                          width: 36,
                          height: 36,
                        )
                      else
                        const Icon(Icons.account_balance, size: 36),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bankShortName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            bankFullName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 16),

                  // Detail Section
                  const Text(
                    "Detail",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price Details - Menggunakan nilai dari data yang diterima
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Harga"),
                      Text(billingDetails['Harga']!),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Biaya Admin"),
                      Text(billingDetails['Biaya Admin']!),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Denda"),
                      Text(billingDetails['Denda']!),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 16),

                  // Total - Menggunakan nilai dari data yang diterima
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        billingDetails['Total Tagihan']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C4EFF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Mengirimkan data yang dibutuhkan ke PageLima
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BayarPdamPageLima(
                              bankName: bankName!,
                              totalAmount: billingDetails['Total Tagihan']!,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Bayar dengan $bankShortName",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
    );
  }
}
