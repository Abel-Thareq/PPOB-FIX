import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'isideposit_pagedua.dart'; // Import halaman kedua


class IsiDepositPage extends StatefulWidget {
  const IsiDepositPage({super.key});

  @override
  State<IsiDepositPage> createState() => _IsiDepositPageState();
}

class _IsiDepositPageState extends State<IsiDepositPage> {
  // Controller untuk mengelola input teks nominal
  final TextEditingController _nominalController = TextEditingController();
  // Untuk melacak nominal yang dipilih dari opsi instan
  String? _selectedInstantNominal;
  // Untuk melacak apakah tombol "Konfirmasi" bisa diaktifkan
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Tambahkan listener untuk memantau perubahan pada TextField
    _nominalController.addListener(_validateAndFormatInput);
  }

  @override
  void dispose() {
    // Hapus listener saat widget dibuang untuk mencegah memory leak
    _nominalController.removeListener(_validateAndFormatInput);
    _nominalController.dispose();
    super.dispose();
  }

  // Fungsi untuk memformat input dengan pemisah ribuan
  void _validateAndFormatInput() {
    String text = _nominalController.text;

    // Hapus semua karakter non-digit kecuali tanda titik yang sudah ada
    String cleanedText = text.replaceAll('.', '');

    // Jika teks kosong, nonaktifkan tombol
    if (cleanedText.isEmpty) {
      setState(() {
        _isButtonEnabled = false;
      });
      return;
    }

    // Ubah teks menjadi angka, tambahkan pemisah ribuan
    String formattedText = '';
    int counter = 0;
    for (int i = cleanedText.length - 1; i >= 0; i--) {
      counter++;
      String digit = cleanedText[i];
      if (counter % 3 == 0 && i != 0) {
        formattedText = '.$digit$formattedText';
      } else {
        formattedText = '$digit$formattedText';
      }
    }

    // Periksa apakah teks yang diformat berbeda dengan teks saat ini
    if (_nominalController.text != formattedText) {
      // Dapatkan posisi kursor saat ini
      int cursorPosition = _nominalController.selection.start;
      // Hitung perbedaan panjang teks setelah diformat
      int lengthDifference = formattedText.length - text.length;
      // Perbarui controller dengan teks yang sudah diformat
      _nominalController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(
          offset: cursorPosition + lengthDifference,
        ),
      );
    }
    _validateButtonState();
  }

  // Fungsi untuk memvalidasi status tombol
  void _validateButtonState() {
    setState(() {
      // Tombol aktif jika TextField tidak kosong atau ada nominal instan yang dipilih
      _isButtonEnabled = _nominalController.text.isNotEmpty || _selectedInstantNominal != null;
    });
  }

  // Fungsi untuk menangani saat tombol nominal instan ditekan
  void _onInstantNominalSelected(String nominal) {
    setState(() {
      _selectedInstantNominal = nominal;
      _nominalController.clear(); // Hapus input manual jika nominal instan dipilih
      _validateButtonState();
    });
  }

  // Fungsi untuk menangani saat tombol Konfirmasi ditekan
  void _handleConfirmation() {
    String nominalToPass;
    if (_selectedInstantNominal != null) {
      // Jika nominal instan dipilih
      nominalToPass = _selectedInstantNominal!;
    } else {
      // Jika nominal diinput manual
      nominalToPass = 'Rp${_nominalController.text}';
    }

    // Navigasi ke halaman IsiDepositPageDua dengan membawa data nominal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IsiDepositPageDua(nominal: nominalToPass),
      ),
    );
  }

  // Fungsi navigasi yang akan digunakan oleh tombol kembali dan tombol kembali Android
  void _navigateToMainScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false,
    );
  }

  // Daftar nominal instan
  final List<String> _instantNominals = [
    'Rp20.000',
    'Rp50.000',
    'Rp100.000',
    'Rp200.000',
    'Rp500.000',
    'Rp1.000.000',
    'Rp5.000.000',
    'Rp10.000.000',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Mencegat tombol kembali bawaan Android
      onWillPop: () async {
        _navigateToMainScreen();
        return false; // Mengembalikan false agar pop default tidak terjadi
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120, // Diperkecil
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 30.0), // Diperkecil
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _navigateToMainScreen, // Tombol kembali UI memanggil fungsi navigasi
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 20), // Diperkecil
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // Diperkecil
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16), // Diperkecil
                    const Text(
                      'Pilih Nominal Pembelian',
                      style: TextStyle(
                        fontSize: 16, // Diperkecil
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF673AB7),
                      ),
                    ),
                    const SizedBox(height: 10), // Diperkecil
                    // Input Nominal Manual
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0), // Diperkecil
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0), // Diperkecil
                        border: Border.all(
                          color: Colors.grey.shade400,
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
                      child: Row(
                        children: [
                          const Text(
                            'Rp',
                            style: TextStyle(
                              fontSize: 14, // Diperkecil
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 6), // Diperkecil
                          Expanded(
                            child: TextField(
                              controller: _nominalController,
                              onChanged: (_) {
                                // Reset pilihan nominal instan saat pengguna mengetik
                                setState(() {
                                  _selectedInstantNominal = null;
                                });
                                // _validateAndFormatInput() sudah dipanggil oleh listener
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: const InputDecoration(
                                hintText: 'Masukkan Nominal',
                                hintStyle: TextStyle(fontSize: 14), // Diperkecil
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Diperkecil

                    // Teks "Pilih nominal instant" di luar box
                    const Text(
                      'Pilih nominal instant',
                      style: TextStyle(
                        fontSize: 14, // Diperkecil
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF673AB7),
                      ),
                    ),
                    const SizedBox(height: 8), // Diperkecil

                    // Box besar untuk nominal instan
                    Container(
                      padding: const EdgeInsets.only(top: 0.00001, left: 12.0, right: 12.0, bottom: 35.0), // Padding atas diperkecil
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0), // Diperkecil
                        border: Border.all(
                          color: Colors.grey.shade400,
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
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0, // Diperkecil
                          mainAxisSpacing: 12.0, // Diperkecil
                          childAspectRatio: 2.8, // Diperkecil
                        ),
                        itemCount: _instantNominals.length,
                        itemBuilder: (context, index) {
                          final nominal = _instantNominals[index];
                          final isSelected = _selectedInstantNominal == nominal;
                          return _buildNominalButton(
                            text: nominal,
                            isSelected: isSelected,
                            onTap: () => _onInstantNominalSelected(nominal),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol Konfirmasi
            Padding(
              padding: const EdgeInsets.all(20.0), // Diperkecil
              child: SizedBox(
                width: double.infinity,
                height: 50, // Ditingkatkan sedikit
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _handleConfirmation : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? const Color(0xFF673AB7)
                        : Colors.grey[300],
                    foregroundColor: _isButtonEnabled
                        ? Colors.white
                        : Colors.grey[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16, // Ditingkatkan sedikit
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Konfirmasi'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat tombol nominal instan
  Widget _buildNominalButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8), // Diperkecil
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1EEFF) : Colors.white,
          borderRadius: BorderRadius.circular(8), // Diperkecil
          border: Border.all(
            color: isSelected ? const Color(0xFF673AB7) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13, // Diperkecil
            fontWeight: FontWeight.w500,
            color: isSelected ? const Color(0xFF673AB7) : Colors.black87,
          ),
        ),
      ),
    );
  }
}
