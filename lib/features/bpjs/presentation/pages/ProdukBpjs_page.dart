import 'package:flutter/material.dart';
import 'package:ppob_app/features/bpjs/presentation/pages/bpjs_page.dart';
import 'package:ppob_app/features/bpjs/presentation/pages/tagihanbpjs_satu.dart';

class ProdukBpjsPage extends StatefulWidget {
  const ProdukBpjsPage({super.key});

  @override
  State<ProdukBpjsPage> createState() => _ProdukBpjsPageState();
}

class _ProdukBpjsPageState extends State<ProdukBpjsPage> {
  String? selectedJenisBpjs;
  String _prefixText = '';
  late TextEditingController _nomorController;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nomorController = TextEditingController();
    _nomorController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _nomorController.removeListener(_validateInput);
    _nomorController.dispose();
    super.dispose();
  }

  void _validateInput() {
    final nomor = _nomorController.text;
    final isValid = selectedJenisBpjs != null &&
        nomor.length == 11 &&
        _isNumeric(nomor);

    setState(() {
      _isButtonEnabled = isValid;
    });
  }

  bool _isNumeric(String s) {
    if (s.isEmpty) return false;
    return double.tryParse(s) != null;
  }

  void _handleContinue() {
    // Gabungkan prefix dan nomor pembayaran menjadi satu string
    final fullNomorPembayaran = _prefixText.replaceAll(RegExp(r'[()]'), '') + _nomorController.text;

    // Navigasi ke TagihanBpjsSatuPage dan kirimkan semua data yang diperlukan
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TagihanBpjsSatuPage(
          totalPesanan: 35000, // Nilai dummy
          biayaAdmin: 2500, // Nilai dummy
          jenisBpjs: selectedJenisBpjs!, // Kirimkan jenis BPJS yang terpilih
          nomorPembayaran: fullNomorPembayaran, // Kirimkan nomor pembayaran lengkap
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigasi ke BpjsPage() saat tombol kembali fisik ditekan
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BpjsPage()),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            // Header
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
                      color: Colors.white,
                      iconSize: 28,
                      onPressed: () {
                        // Navigasi ke BpjsPage() saat tombol kembali UI ditekan
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const BpjsPage()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Konten formulir
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul "Bayar BPJS" dan Deskripsi di bawah header
                    const SizedBox(height: 12),
                    const Text(
                      'Bayar BPJS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // "Pilih jenis BPJS" kembali ke tengah
                    const Center(
                      child: Text(
                        'Pilih jenis BPJS dan nomor BPJS anda',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Label "Jenis BPJS"
                    const Text(
                      'Jenis BPJS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6245FC),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Input Jenis BPJS (Card)
                    _buildSelectionCard(
                      icon: 'assets/images/shield.png',
                      title: selectedJenisBpjs ?? 'Pilih Jenis BPJS',
                      onTap: _showJenisBpjsPicker,
                    ),
                    const SizedBox(height: 20),

                    // Label "Nomor Pembayaran"
                    const Text(
                      'Nomor Pembayaran',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6245FC),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Input Nomor Pembayaran (Card dengan prefix terpisah)
                    _buildSelectionCardWithTextField(
                      icon: 'assets/images/searchbold.png',
                      hintText: 'Nomor BPJS',
                      prefixText: _prefixText,
                      controller: _nomorController,
                    ),

                    // Teks petunjuk di bawah input nomor
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Masukkan 11 digit terakhir nomor kartu BPJS anda.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol "Lanjutkan" tetap di bagian bawah
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _handleContinue : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? const Color(0xFF6245FC) // Warna baru ketika enabled
                        : Colors.grey[300], // Warna abu-abu ketika disabled
                    foregroundColor: _isButtonEnabled
                        ? Colors.white // Warna teks putih ketika enabled
                        : Colors.grey[600], // Warna teks abu-abu ketika disabled
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Lanjutkan'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: 22, height: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCardWithTextField({
    required String icon,
    required String hintText,
    required String prefixText,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(icon, width: 22, height: 22),
          const SizedBox(width: 10),
          // Widget Text terpisah untuk menampilkan prefix secara permanen
          if (prefixText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Text(
                prefixText,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                counterText: '', // Menghilangkan counter default
              ),
              keyboardType: TextInputType.number,
              maxLength: 11,
            ),
          ),
        ],
      ),
    );
  }

  void _showJenisBpjsPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Pilih Jenis BPJS",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: Image.asset('assets/images/bpjs.png', width: 22, height: 22),
              title: const Text('BPJS Kesehatan', style: TextStyle(fontSize: 14)),
              onTap: () {
                setState(() {
                  selectedJenisBpjs = 'BPJS Kesehatan';
                  _prefixText = '(88888)';
                  _nomorController.clear();
                });
                Navigator.pop(context);
                _validateInput();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: Image.asset('assets/images/bpjs.png', width: 22, height: 22),
              title: const Text('BPJS Denda', style: TextStyle(fontSize: 14)),
              onTap: () {
                setState(() {
                  selectedJenisBpjs = 'BPJS Denda';
                  _prefixText = '(88888)';
                  _nomorController.clear();
                });
                Navigator.pop(context);
                _validateInput();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: Image.asset('assets/images/bpjs.png', width: 22, height: 22),
              title: const Text('BPJS Ketenagakerjaan', style: TextStyle(fontSize: 14)),
              onTap: () {
                setState(() {
                  selectedJenisBpjs = 'BPJS Ketenagakerjaan';
                  _prefixText = '(88881)';
                  _nomorController.clear();
                });
                Navigator.pop(context);
                _validateInput();
              },
            ),
          ],
        );
      },
    );
  }
}
