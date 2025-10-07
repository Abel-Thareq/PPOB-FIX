import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/listrik/presentation/pages/nontagihan_Listrikdua.dart';

class NontagihanListriksatu extends StatefulWidget {
  const NontagihanListriksatu({super.key});

  @override
  State<NontagihanListriksatu> createState() => _NontagihanListriksatuState();
}

class _NontagihanListriksatuState extends State<NontagihanListriksatu> {
  final TextEditingController _meterNumberController = TextEditingController();

  @override
  void dispose() {
    _meterNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with image background and back button
          Stack(
            children: [
              // Header Image Background
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.white,
                child: Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Back Button
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

          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Product Title
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/iconpln.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Non-Tagihan Listrik',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'PLN',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Meter Number Input
                  const Text(
                    'No.Meter / ID Pelanggan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _meterNumberController,
                    keyboardType: TextInputType.number, // Keyboard angka saja
                    decoration: InputDecoration(
                      hintText: 'Masukan No.Meter / ID Pelanggan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'No. Meter atau ID Pelanggan adalah nomor yang terdapat pada kartu pelanggan',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed "Lanjutkan" Button at bottom
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Lanjutkan',
              onPressed: () {
                if (_meterNumberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silakan masukkan No. Meter / ID Pelanggan'),
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NonTagihanListrikDua(
                      meterNumber: _meterNumberController.text,
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