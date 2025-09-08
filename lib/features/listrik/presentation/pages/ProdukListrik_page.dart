import 'package:flutter/material.dart';
import 'package:ppob_app/features/listrik/presentation/pages/listrik_page.dart';
import 'package:ppob_app/features/listrik/presentation/pages/token_Listriksatu.dart';
import 'package:ppob_app/features/listrik/presentation/pages/tagihan_Listriksatu.dart';
import 'package:ppob_app/features/listrik/presentation/pages/nontagihan_Listriksatu.dart';

class ListrikProdukPage extends StatelessWidget {
  const ListrikProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ListrikPage()),
        );
        return false; // cegah pop default
      },
      child: Scaffold(
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
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      iconSize: 28,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ListrikPage()),
                        );
                      },
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

                    // Product Type Title
                    const Center(
                      child: Text(
                        'Pilih jenis produk listrik',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Product Options
                    Column(
                      children: [
                        _buildProductOption(context, 'Token Listrik', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TokenListrik1Page(),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        _buildProductOption(context, 'Tagihan Listrik', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TagihanListriksatu(),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        _buildProductOption(context, 'Non-Tagihan Listrik', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NontagihanListriksatu(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Fixed "Lanjutkan" Button at bottom
          ],
        ),
      ),
    );
  }

  Widget _buildProductOption(BuildContext context, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/iconpln.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
