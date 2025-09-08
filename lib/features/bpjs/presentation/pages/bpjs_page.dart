import 'package:flutter/material.dart';
import 'package:ppob_app/core/widgets/custom_button.dart';
import 'package:ppob_app/features/bpjs/presentation/pages/ProdukBpjs_page.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';

// Ganti StatelessWidget menjadi StatefulWidget
class BpjsPage extends StatefulWidget {
  final String? lastPaymentType;
  final String? lastPaymentNumber;

  const BpjsPage({
    super.key,
    this.lastPaymentType,
    this.lastPaymentNumber,
  });

  @override
  State<BpjsPage> createState() => _BpjsPageState();
}

class _BpjsPageState extends State<BpjsPage> {
  // Variabel untuk menyimpan data pembayaran terakhir
  String? _lastPaymentType;
  String? _lastPaymentNumber;

  @override
  void initState() {
    super.initState();
    // Inisialisasi state dengan data yang diterima dari constructor
    _lastPaymentType = widget.lastPaymentType;
    _lastPaymentNumber = widget.lastPaymentNumber;
  }

  // Fungsi navigasi yang akan digunakan oleh tombol kembali dan tombol kembali Android
  void _navigateToMainScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateToMainScreen();
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            // Header dengan latar belakang gambar dan tombol kembali
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
                    padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 28,
                      onPressed: _navigateToMainScreen,
                    ),
                  ),
                ),
              ],
            ),

            // Konten utama yang dapat digulir
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Bagian Pembayaran Terakhir
                    Text(
                      'Pembayaran BPJS Terakhir',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tampilkan data transaksi terakhir jika ada
                    if (_lastPaymentType != null && _lastPaymentNumber != null)
                      _LastPaymentCard(
                        jenisBpjs: _lastPaymentType!,
                        nomorPembayaran: _lastPaymentNumber!,
                      )
                    else
                    // Keadaan kosong Pembayaran
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              'Kamu belum pernah',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'membayar tagihan BPJS.',
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

                    // Bagian Daftar Tersimpan
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

                    // Kotak Pencarian
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
                            hintText: 'cari nama disini',
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

                    // Keadaan kosong Daftar Tersimpan
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

            // Tombol "Tambah Transaksi Baru" tetap di bagian bawah
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                text: 'Tambah Transaksi Baru',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProdukBpjsPage(),
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

// Widget pembantu untuk card pembayaran terakhir
class _LastPaymentCard extends StatelessWidget {
  final String jenisBpjs;
  final String nomorPembayaran;

  const _LastPaymentCard({
    required this.jenisBpjs,
    required this.nomorPembayaran,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/bpjs.png', // Ganti dengan path logo BPJS yang sesuai
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jenisBpjs,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  nomorPembayaran,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}