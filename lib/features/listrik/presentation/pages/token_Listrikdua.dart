import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/listrik/presentation/pages/token_Listriktiga.dart';

class TokenListrik2Page extends StatefulWidget {
  final String meterNumber;

  const TokenListrik2Page({
    super.key,
    required this.meterNumber,
  });

  @override
  State<TokenListrik2Page> createState() => _TokenListrik2PageState();
}

class _TokenListrik2PageState extends State<TokenListrik2Page> {
  bool isSaved = false;
  String? selectedNominal;

  // Fungsi untuk mengonversi string nominal ke integer
  int _parseNominalToInt(String nominal) {
    // Hapus "Rp" dan titik, lalu konversi ke integer
    String cleaned = nominal.replaceAll('Rp', '').replaceAll('.', '');
    return int.tryParse(cleaned) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    // Format nomor meter untuk ditampilkan (misalnya: 5210XXXXX)
    String formatMeterNumber(String meterNumber) {
      if (meterNumber.length <= 4) {
        return meterNumber;
      }
      return '${meterNumber.substring(0, 4)}${'X' * (meterNumber.length - 4)}';
    }

    // Format nama untuk ditampilkan (misalnya: PONXXXXX)
    String formatName(String name) {
      if (name.length <= 3) {
        return name;
      }
      return '${name.substring(0, 3)}${'X' * (name.length - 3)}';
    }

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
                  padding: const EdgeInsets.all(11.0),
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
                            formatName('PONPES ASSALAFIYYAH 2'), // Menggunakan fungsi formatName
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
                          Text(
                            '${formatMeterNumber(widget.meterNumber)} - SI / 5500 VA',
                            style: const TextStyle(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
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
                      builder: (context) => TokenListrik3Page(
                        selectedNominal: _parseNominalToInt(selectedNominal!),
                      ),
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