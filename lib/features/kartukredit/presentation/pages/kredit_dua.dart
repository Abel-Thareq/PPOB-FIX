import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/kartukredit/presentation/pages/kredit_tiga.dart';

// Definisi model untuk data bank
class Bank {
  final String name;
  final String assetPath;

  const Bank({required this.name, required this.assetPath});
}

class KreditDuaPage extends StatefulWidget {
  const KreditDuaPage({super.key});

  @override
  State<KreditDuaPage> createState() => _KreditDuaPageState();
}

class _KreditDuaPageState extends State<KreditDuaPage> {
  final TextEditingController _nomorKartuController = TextEditingController();
  final List<Bank> banks = const [
    Bank(name: 'BRI', assetPath: 'assets/images/bankbri.png'),
    Bank(name: 'BNI', assetPath: 'assets/images/bankbni.png'),
    Bank(name: 'Mandiri', assetPath: 'assets/images/bankmandiri.png'),
    Bank(name: 'DBS Card', assetPath: 'assets/images/bankdbs.png'),
    Bank(name: 'HSBC Card', assetPath: 'assets/images/bankhsbc.png'),
  ];

  Bank? selectedBank;

  void _showBankListPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Text(
                    'Pilih Bank',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: banks.length,
                      itemBuilder: (context, index) {
                        final bank = banks[index];
                        return ListTile(
                          leading: Image.asset(
                            bank.assetPath,
                            width: 32,
                          ),
                          title: Text(bank.name),
                          onTap: () {
                            setState(() {
                              selectedBank = bank;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
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
                    color: Colors.black,
                    iconSize: 28,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),

          // Konten utama
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pilih Bank',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _showBankListPopup,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          selectedBank != null
                              ? Image.asset(
                                  selectedBank!.assetPath,
                                  width: 24,
                                  height: 24,
                                )
                              : Icon(
                                  Icons.account_balance,
                                  color: Colors.grey[600],
                                ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              selectedBank?.name ?? 'Pilih Bank',
                              style: TextStyle(
                                fontSize: 14,
                                color: selectedBank == null ? Colors.grey[600] : Colors.black,
                              ),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Nomor Tujuan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextField(
                        controller: _nomorKartuController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image.asset(
                              'assets/images/credit_card.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          hintText: 'Masukkan Nomor Kartu Kredit',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Tombol "Lanjutkan"
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Lanjutkan',
              onPressed: () {
                // Validasi input
                if (selectedBank == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pilih bank terlebih dahulu')),
                  );
                  return;
                }
                
                if (_nomorKartuController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Masukkan nomor kartu terlebih dahulu')),
                  );
                  return;
                }

                // Navigasi ke halaman 3 dengan data yang dipilih
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KreditTigaPage(
                      namaBank: selectedBank!.name,
                      nomorKartu: _nomorKartuController.text,
                      // Data dummy untuk parameter lainnya
                      nominalTagihan: 1500000, // Contoh nilai dummy
                      biayaAdmin: 2500, // Contoh nilai dummy
                      namaPelanggan: 'John Doe', // Contoh nilai dummy
                      jatuhTempo: '15 Jan 2024', // Contoh nilai dummy
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
}