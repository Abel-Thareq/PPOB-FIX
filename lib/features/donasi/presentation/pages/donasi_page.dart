import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/donasi/presentation/pages/donasi_dua.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

class DonasiPage extends StatelessWidget {
  const DonasiPage({super.key});

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
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 28,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()), 
                        (route) => false,
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

                  // Pembayaran Terakhir Section
                  Text(
                    'Pembayaran Terakhir',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Empty State Pembayaran PBB
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'Kamu, belum Pernah',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'melakukan pembayaran pajak PBB.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Yuk mulai transaksimu sekarang.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Divider
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 24),

                  // Daftar Tersimpan Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daftar Tersimpan',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          '+ Tambah',
                          style: TextStyle(
                            color: Color(0xFF5938FB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image.asset(
                              'assets/images/searchlight.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          hintText: 'Cari nama disini',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Empty State Daftar Tersimpan
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Belum Ada Daftar Tersimpan',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed "Tambah Transaksi Baru" Button at bottom
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              text: 'Tambah Transaksi Baru',
              onPressed: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(
                      builder: (context) => const DonasiDuaPage(),
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