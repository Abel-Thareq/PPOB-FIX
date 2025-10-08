import 'package:flutter/material.dart';
import 'package:ppob_app/features/pdam/presentation/pages/bayarpdam_pageempat.dart';
import 'package:ppob_app/features/pdam/presentation/pages/bayarpdam_pageempatmodipay.dart'; // Import halaman baru

class BayarPdamPageTiga extends StatefulWidget {
  // Tambahkan properti untuk menerima data tagihan
  final Map<String, String> billingDetails;

  const BayarPdamPageTiga({
    super.key,
    required this.billingDetails,
  });

  @override
  State<BayarPdamPageTiga> createState() => _BayarPdamPageTigaState();
}

class _BayarPdamPageTigaState extends State<BayarPdamPageTiga>
    with SingleTickerProviderStateMixin {
  String? selectedMethod;
  bool showBankOptions = false;

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

  void _selectPayment(String title, {String? bankName}) {
    setState(() {
      selectedMethod = title;
      showBankOptions = false;
    });

    // Setelah 3 detik, otomatis pindah halaman
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      // Cek metode pembayaran yang dipilih
      if (title == "Saldo Modipay") {
        // Pindah ke BayarPdamPageEmpatModipay
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BayarPdamPageEmpatModipay(
              billingDetails: widget.billingDetails,
            ),
          ),
        );
      } else {
        // Pindah ke BayarPdamPageEmpat untuk transfer bank atau metode lain
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BayarPdamPageEmpat(
              billingDetails: widget.billingDetails,
              bankName: bankName,
            ),
          ),
        );
      }
    });
  }

  Widget _buildPaymentOption(String title) {
    return InkWell(
      onTap: () {
        if (title == "Transfer Bank") {
          setState(() {
            showBankOptions = !showBankOptions;
          });
        } else {
          _selectPayment(title);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            if (title == "Transfer Bank")
              Icon(
                showBankOptions ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankOption(String bankName) {
    String? iconPath = _getBankIconPath(bankName);
    return InkWell(
      onTap: () {
        _selectPayment("Transfer Bank ($bankName)", bankName: bankName);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            if (iconPath != null)
              Image.asset(iconPath, width: 24, height: 24)
            else
              const Icon(Icons.account_balance, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  bankName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildBankList() {
    return Column(
      children: [
        _buildBankOption("Bank BRI"),
        _buildBankOption("Bank BCA"),
        _buildBankOption("Bank MANDIRI"),
        _buildBankOption("Bank BNI"),
        _buildBankOption("Bank Syariah Indonesia"),
        _buildBankOption("Bank Lainnya"),
      ],
    );
  }

  Widget _buildTransferBankWithOptions() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showBankOptions = !showBankOptions;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(8),
                  bottom: showBankOptions ? Radius.zero : const Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Transfer Bank",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Icon(
                    showBankOptions ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (showBankOptions) ...[
            const Divider(height: 1, color: Colors.grey),
            _buildBankList(),
          ],
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (selectedMethod != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Processing payment with:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              selectedMethod!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      );
    } else {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Metode Pembayaran",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPaymentOption("Saldo Modipay"),
          _buildTransferBankWithOptions(),
          _buildPaymentOption("Kartu Debit/Kredit"),
          _buildPaymentOption("Cicilan Kartu Kredit"),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // HEADER - SAMA SEPERTI DI BayarPDAMPagedua
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 13.0),
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

          // CONTENT
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }
}