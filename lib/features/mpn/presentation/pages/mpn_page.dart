import 'package:flutter/material.dart';
import 'package:ppob_app/features/main_screen/main_screen.dart';
import 'package:ppob_app/features/mpn/presentation/pages/mpn_dua.dart';

class MpnPage extends StatefulWidget {
  const MpnPage({super.key});

  @override
  State<MpnPage> createState() => _MpnPageState();
}

class _MpnPageState extends State<MpnPage> {
  final TextEditingController _billingCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _billingCodeController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _billingCodeController.removeListener(_onFieldChanged);
    _billingCodeController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    setState(() {
      // Perubahan state akan dipicu saat teks berubah
    });
  }

  // Fungsi untuk navigasi ke MainScreen
  void _navigateToMainScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (Route<dynamic> route) => false,
    );
  }

  bool get _isFormValid {
    return _billingCodeController.text.length == 15;
  }

  @override
  Widget build(BuildContext context) {
    final bool formIsValid = _isFormValid;
    final Color buttonColor = formIsValid ? const Color(0xFF6C4EFF) : Colors.grey[400]!;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _navigateToMainScreen();
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan latar belakang dan tombol kembali
            Stack(
              children: [
                // Latar Belakang Gambar Header
                Image.asset(
                  'assets/images/header.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 120,
                ),

                // Tombol Kembali
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0),
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

            // Konten utama yang bisa di-scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kode Billing',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Masukkan 15 digit kode billing',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Bagian "Kode Billing"
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Image.asset('assets/images/billing.png', width: 20, height: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _billingCodeController,
                              decoration: InputDecoration(
                                hintText: 'Masukkan Kode Billing',
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.normal,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              style: const TextStyle(fontSize: 14),
                              keyboardType: TextInputType.number,
                              maxLength: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_billingCodeController.text.length}/15 digit',
                      style: TextStyle(
                        fontSize: 12,
                        color: _billingCodeController.text.length == 15 
                            ? Colors.green 
                            : Colors.grey,
                      ),
                    ),
                    
                    // Box informasi
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1EEFF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF6C4EFF),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informasi',
                            style: TextStyle(
                              color: Color(0xFF6C4EFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '1. Jenis Pembayaran yang dapat dilakukan: Pajak, PNBP, Bea Cukai.\n'
                            '2. Pembayaran PNBP yaitu KUA, Paspor, Visa, e-Tilang, SBN, BPN, dan Pelayanan Negara lainnya.\n'
                            '3. Bukti Penerimaan Negara akan dikirimkan juga melalui email.\n'
                            '4. Limit pembayaran: Reguler (Rp300.000.000), Premium (Rp500.000.000). Untuk pembayaran melebihi limit silahkan dilakukan melalui Customer Service.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol "Lanjutkan" tetap di bawah
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: formIsValid
                    ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MpnDuaPage(
                            billingCode: _billingCodeController.text,
                          ),
                        ),
                      );
                    }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}