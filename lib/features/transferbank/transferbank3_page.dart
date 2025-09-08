import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:ppob_app/features/transferbank/pinpage_transfer.dart';

// 🔹 Helper getBankLogo()
String getBankLogo(String bankName) {
  switch (bankName) {
    case "Bank BRI":
      return "assets/images/bank_bri.png";
    case "Bank Mandiri":
      return "assets/images/bank_mandiri.png";
    case "Bank BNI":
      return "assets/images/bank_bni.png";
    case "Bank BCA":
      return "assets/images/bank_bca.png";
    case "Bank BSI":
      return "assets/images/bank_bsi.png";
    case "Bank BTN":
      return "assets/images/bank_btn.png";
    case "Bank CIMB NIAGA":
      return "assets/images/bank_cimb.png";
    case "Bank DANAMON":
      return "assets/images/bank_danamon.png";
    case "Bank PERMATA":
      return "assets/images/bank_permata.png";
    case "Bank PANIN":
      return "assets/images/bank_panin.png";
    default:
      return "assets/images/default_bank.png";
  }
}

class TransferBank3Page extends StatelessWidget {
  final String bankName;
  final String rekeningNumber;
  final String nominal; // nominal dalam string berformat (mis: "150.000")
  final String catatan;
  final String namaPenerima;

  const TransferBank3Page({
    super.key,
    required this.bankName,
    required this.rekeningNumber,
    required this.nominal,
    required this.catatan,
    required this.namaPenerima,
  });

  @override
  Widget build(BuildContext context) {
    final dividerColor = const Color(0xFFE6E7EF);

    // Gunakan satu sumber kebenaran untuk biaya admin
    const int biayaAdmin = 1000;

    // Ubah nominal string menjadi int (hilangkan . dan ,)
    final int nominalInt =
        int.tryParse(nominal.replaceAll(".", "").replaceAll(",", "")) ?? 0;

    final int total = nominalInt + biayaAdmin;

    // Format tampilan rupiah pakai titik per ribuan
    final formatCurrency = NumberFormat("#,###", "id_ID");
    final formattedNominal =
        formatCurrency.format(nominalInt).replaceAll(",", ".");
    final formattedAdmin =
        formatCurrency.format(biayaAdmin).replaceAll(",", ".");
    final formattedTotal =
        formatCurrency.format(total).replaceAll(",", ".");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 140,
                color: Colors.white,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Info penerima dengan logo bank
                  Row(
                    children: [
                      Image.asset(
                        getBankLogo(bankName),
                        width: 52,
                        height: 52,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaPenerima,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            bankName,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5), // ✅ halus
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            rekeningNumber,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5), // ✅ halus
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Switch Tambah ke daftar tersimpan
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: dividerColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tambah Ke Daftar Tersimpan",
                            style: TextStyle(fontSize: 14)),
                        Switch(
                          value: true,
                          activeColor: const Color(0xFF5938FB),
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Konfirmasi",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Box Konfirmasi
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: dividerColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _rowInfo("Catatan", catatan.isEmpty ? "-" : catatan),
                        const SizedBox(height: 8),
                        _rowInfo("Nominal", "Rp $formattedNominal"),
                        const SizedBox(height: 8),
                        _rowInfo("Biaya Admin", "Rp $formattedAdmin"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Box Total
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: dividerColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _rowInfo("Total", "Rp $formattedTotal",
                        bold: true, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Button Lanjutkan
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              text: "Lanjutkan",
              onPressed: () {
                // Kirim data ke halaman PIN
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PinTransferPage(
                      bankName: bankName,
                      rekeningNumber: rekeningNumber,
                      namaPenerima: namaPenerima,
                      nominal: nominalInt,
                      biayaAdmin: biayaAdmin,
                      total: total,
                      catatan: catatan,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowInfo(String label, String value,
      {bool bold = false, Color color = Colors.black87}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}