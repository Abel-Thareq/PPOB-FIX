import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/listrik/presentation/pages/token_Listriktiga.dart'; // pastikan import page tujuan

class TokenListrik2Page extends StatefulWidget {
  const TokenListrik2Page({super.key});

  @override
  State<TokenListrik2Page> createState() => _TokenListrik2PageState();
}

class _TokenListrik2PageState extends State<TokenListrik2Page> {
  bool isSaved = false;
  String? selectedNominal;

  @override
  Widget build(BuildContext context) {
    const originalName = "PONPES ASSALAFIYYAH 2";
    final maskedName =
    originalName.replaceRange(3, null, "X" * (originalName.length - 3));

    return Scaffold(
      body: Column(
        children: [
          // HEADER
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
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),

          // CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // USERNAME + ICON PLN
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/iconpln.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            maskedName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Token Listrik',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const Text(
                            '521041373414 - SI / 5500 VA',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // SWITCH SAVE
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tambah ke Daftar Tersimpan',
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 50,
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: isSaved ? Colors.purple : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSaved
                                    ? Colors.purple
                                    : Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            child: AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: isSaved
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // TITLE
                  const Text(
                    'Pilih Nominal Pembelian',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // BOX BESAR LIST NOMINAL
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.2,
                      children: [
                        _buildNominalButton('Rp20.000'),
                        _buildNominalButton('Rp50.000'),
                        _buildNominalButton('Rp100.000'),
                        _buildNominalButton('Rp200.000'),
                        _buildNominalButton('Rp500.000'),
                        _buildNominalButton('Rp1.000.000'),
                        _buildNominalButton('Rp5.000.000'),
                        _buildNominalButton('Rp10.000.000'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BUTTON CONFIRMASI
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Confirmasi',
              onPressed: () {
                if (selectedNominal != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TokenListrik3Page(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silakan pilih nominal terlebih dahulu'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNominalButton(String amount) {
    final bool isSelected = selectedNominal == amount;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        elevation: 1,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      ),
      onPressed: () {
        setState(() {
          selectedNominal = amount;
        });
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
