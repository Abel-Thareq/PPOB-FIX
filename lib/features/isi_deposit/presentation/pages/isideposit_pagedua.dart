import 'package:flutter/material.dart';
import 'isideposit_pagetiga.dart';

class IsiDepositPageDua extends StatefulWidget {
  final String? nominal; // Variabel untuk menerima data nominal

  const IsiDepositPageDua({super.key, this.nominal});

  @override
  State<IsiDepositPageDua> createState() => _IsiDepositPageDuaState();
}

class _IsiDepositPageDuaState extends State<IsiDepositPageDua> {
  // Variabel untuk melacak opsi yang diperluas
  String _expandedSection = '';

  // Data untuk opsi pembayaran
  final Map<String, List<Map<String, dynamic>>> _paymentOptions = {
    'Transfer Bank': [
      {'name': 'Bank BRI', 'icon': 'assets/images/iconbri.png', 'shortName': 'BRI'},
      {'name': 'Bank BCA', 'icon': 'assets/images/iconbca.png', 'shortName': 'BCA'},
      {'name': 'Bank BNI', 'icon': 'assets/images/iconbni.png', 'shortName': 'BNI'},
      {'name': 'Bank Mandiri', 'icon': 'assets/images/iconmandiri.png', 'shortName': 'MANDIRI'},
    ],
    'Virtual Account': [
      {'name': 'Bank BRI', 'icon': 'assets/images/iconbri.png', 'shortName': 'BRI'},
      {'name': 'Bank BCA', 'icon': 'assets/images/iconbca.png', 'shortName': 'BCA'},
      {'name': 'Bank MANDIRI', 'icon': 'assets/images/iconmandiri.png', 'shortName': 'MANDIRI'},
      {'name': 'Bank BNI', 'icon': 'assets/images/iconbni.png', 'shortName': 'BNI'},
      {'name': 'Bank Permata', 'icon': 'assets/images/iconpermata.png', 'shortName': 'Permata'},
    ],
    'E-Wallet & QRIS': [
      {'name': 'Gopay', 'icon': 'assets/images/icongopay.png', 'shortName': 'Gopay'},
      {'name': 'ShopeePay', 'icon': 'assets/images/iconshopeepay.png', 'shortName': 'ShopeePay'},
      {'name': 'QRIS', 'icon': 'assets/images/iconqris.png', 'shortName': 'QRIS'},
      {'name': 'DANA', 'icon': 'assets/images/icondana.png', 'shortName': 'DANA'},
    ],
    'Counter': [
      {'name': 'Alfamart', 'icon': 'assets/images/Alfamart.png', 'shortName': 'Alfamart'},
      {'name': 'Indomaret', 'icon': 'assets/images/Indomaret.png', 'shortName': 'Indomaret'},
    ],
  };

  // Fungsi untuk menangani klik pada item bank/layanan
  void _onPaymentSelected(Map<String, dynamic> selectedPayment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IsiDepositPageTiga(
          selectedPayment: selectedPayment, // Meneruskan seluruh objek data pembayaran
          nominal: widget.nominal, // Meneruskan data nominal
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
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
                  padding: const EdgeInsets.only(top: 27.0, left: 27.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilih Pembayaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF673AB7),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Membangun daftar opsi pembayaran secara dinamis
                  ..._paymentOptions.keys.map((category) {
                    final isExpanded = _expandedSection == category;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildPaymentOption(
                        title: category,
                        isExpanded: isExpanded,
                        onTap: () {
                          setState(() {
                            _expandedSection = isExpanded ? '' : category;
                          });
                        },
                        children: isExpanded
                            ? _buildPaymentList(category)
                            : [],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk opsi pembayaran utama yang dapat diperluas
  Widget _buildPaymentOption({
    required String title,
    required VoidCallback onTap,
    bool isExpanded = false,
    List<Widget> children = const [],
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Baris judul opsi pembayaran
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ],
            ),
            // Daftar bank/layanan akan ditampilkan di sini jika isExpanded true
            if (children.isNotEmpty) ...children,
          ],
        ),
      ),
    );
  }

  // Widget untuk konten daftar bank/layanan yang dapat digunakan kembali
  List<Widget> _buildPaymentList(String category) {
    final List<Map<String, dynamic>> items = _paymentOptions[category] ?? [];
    List<Widget> listItems = [];

    for (int i = 0; i < items.length; i++) {
      listItems.add(
        InkWell(
          onTap: () => _onPaymentSelected(items[i]),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 12),
            child: Row(
              children: [
                if (items[i]['icon'] != null)
                  Image.asset(items[i]['icon'] as String, width: 30, height: 30)
                else
                  const Icon(Icons.account_balance, size: 30),
                const SizedBox(width: 16),
                Text(
                  items[i]['name'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      // Tambahkan Divider setelah setiap item, kecuali yang terakhir
      if (i < items.length - 1) {
        listItems.add(
          const Divider(
            height: 24,
            thickness: 1,
            color: Color(0xFFF0F0F0),
            indent: 20,
            endIndent: 0,
          ),
        );
      }
    }
    return [
      const SizedBox(height: 8), // Jarak antara judul dan daftar
      ...listItems,
    ];
  }
}
