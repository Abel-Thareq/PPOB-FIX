import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/pascabayar/presentation/pages/pascabayar_dua.dart';

class PascabayarPage extends StatelessWidget {
  const PascabayarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(
          children: [
            // Header dengan latar belakang dan tombol kembali
            Stack(
              children: [
                // Latar Belakang Gambar Header
                Container(
                  width: double.infinity,
                  height: 120,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // Tombol Kembali
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

            // Konten utama yang bisa di-scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Bagian "Pembayaran Terakhir"
                    Text(
                      'Pembayaran Terakhir',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),

                    // Tampilan kosong untuk "Pembayaran Terakhir"
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Kamu: belum pernah',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'melakukan transaksi.',
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

                    // Garis pemisah
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 24),

                    // Bagian "Daftar Tersimpan"
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
                          onPressed: () {
                            // TODO: Tambahkan fungsi untuk menambahkan daftar baru
                          },
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
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
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

                    // Tampilan kosong untuk "Daftar Tersimpan"
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

            // Tombol "Tambah Transaksi Baru" tetap di bawah
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                text: 'Tambah Transaksi Baru',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PascabayarDuaPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
